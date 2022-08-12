##############################
# Build & generated src rules
##############################
HOME := $(HOME)
NPM := /usr/local/bin/npm
NG := /usr/local/bin/ng
CARGO := $(HOME)/.cargo/bin/cargo
PROTOC := /usr/bin/protoc
PROTOC_GRPC_WEB := /usr/bin/protoc-gen-grpc-web
NGINX := /usr/sbin/nginx

builders-setup: $(PROTOC) $(PROTOC_GRPC_WEB) $(NPM) $(CARGO) $(NG) web-client/node_modules

$(NPM):
	sudo apt install -y npm

$(NG): $(NPM)
	$(NPM) install -g @angular/cli

web-client/node_modules: $(NPM) web-client/package.json
	cd web-client && $(NPM) install && touch -m node_modules

$(CARGO):
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

$(PROTOC):
	sudo apt install -y protobuf-compiler

$(PROTOC_GRPC_WEB):
	wget https://github.com/grpc/grpc-web/releases/download/1.3.1/protoc-gen-grpc-web-1.3.1-linux-x86_64
	sudo mv protoc-gen-grpc-web-1.3.1-linux-x86_64 /usr/bin/protoc-gen-grpc-web
	sudo chmod +x /usr/bin/protoc-gen-grpc-web

web-client/src/generated: $(PROTOC) $(PROTOC_GRPC_WEB) proto/*.proto
	mkdir -p web-client/src/generated
	$(PROTOC) -I="proto" webnovel_reader.proto \
		--js_out=import_style=commonjs:web-client/src/generated \
		--grpc-web_out=import_style=typescript,mode=grpcwebtext:web-client/src/generated
	touch -m $@

format: $(CARGO) $(NPM) web-client/node_modules
	cd web-client && $(NPM) run format
	cd backend && $(CARGO) fmt

lint: $(CARGO) $(NPM) web-client/node_modules format
	cd web-client && $(NPM) run lint
	cd backend && $(CARGO) fix --allow-staged

clean:
	rm -rf web-client/src/generated
	rm -rf release
	rm -rf backend/target
	rm -rf web-client/dist

##########################
# Nginx rules
##########################
$(NGINX):
	sudo apt install -y nginx

/etc/nginx/sites-enabled/dev.conf: $(NGINX) nginx/dev.nginx.conf
	sudo cp nginx/dev.nginx.conf $@

/etc/nginx/sites-enabled/webnovel-reader-prod.conf: $(NGIX) nginx/prod.nginx.conf
	sudo cp nginx/prod.nginx.conf $@

/var/run/nginx.pid: $(NGINX) /etc/nginx/sites-enabled/dev.conf /etc/nginx/sites-enabled/webnovel-reader-prod.conf
	sudo service nginx restart

##########################
# Development server rules
##########################
backend-dev-server: $(CARGO)
	cd backend && $(CARGO) watch -x run

ui-dev-server: $(NPM) $(NG) web-client/src/generated
	cd web-client && $(NPM) run devserver

# Parallely run backend and ui: `make dev-server --jobs=2`
dev-server: /var/run/nginx.pid backend-dev-server ui-dev-server

#####################
# Release build rules
#####################
test: builders-setup format lint
	cd web-client && $(NPM) run test
	cd backend && $(CARGO) test

web-client-release: builders-setup web-client/src/generated
	cd web-client && $(NPM) run build

backend-release: $(CARGO)
	cd backend && $(CARGO) build --release

release: test web-client-release backend-release
	mkdir -p release
	mkdir -p release/ui-files
	cp -r ./web-client/dist/ui/* ./release/ui-files/
	cp ./backend/target/release/backend ./release/server
	cp ./backend/Config-Prod.toml ./release/Config.toml
	cp ./nginx/prod.nginx.conf ./release/nginx.conf
	cp systemd.service ./release/systemd.service

##########################
# Release deployment rules
##########################
deployment: release
	sudo systemctl stop webnovel-reader.service || 0
	sudo mkdir -p /srv/webnovel-reader
	sudo cp release/server /srv/webnovel-reader/server
	sudo cp release/Config.toml /srv/webnovel-reader/Config.toml
	sudo cp -r release/ui-files /srv/webnovel-reader/
	sudo cp release/nginx.conf /etc/nginx/sites-enabled/webnovel-reader-prod.conf
	sudo cp release/systemd.service /lib/systemd/system/webnovel-reader.service
	sudo systemctl daemon-reload
	sudo systemctl restart nginx.service
	sudo systemctl restart webnovel-reader.service


.PHONY: builders-setup format lint clean backend-dev-server ui-dev-server dev-server test web-client-release backend-release release deployment
