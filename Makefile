##############################
# Build & generated src rules
##############################
HOME := $(HOME)
CARGO := $(HOME)/.cargo/bin/cargo
PROTOC := /usr/bin/protoc
PROTOC_GEN_DART := $(HOME)/.pub-cache/bin/protoc-gen-dart
NGINX := /usr/sbin/nginx

builders-setup: $(PROTOC) $(CARGO)

$(CARGO):
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

$(PROTOC):
	sudo apt install -y protobuf-compiler

$(PROTOC_GEN_DART):
	dart pub global activate protoc_plugin

frontend/lib/generated: $(PROTOC_GEN_DART) $(PROTOC) proto/*.proto
	mkdir -p $@
	export PATH="$(PATH)":"$(HOME)/.pub-cache/bin" && \
	$(PROTOC) --dart_out=grpc:frontend/lib/generated -Iproto \
		proto/user_account.proto \
		proto/webnovel_reader.proto
	touch -m $@

format: $(CARGO)
	cd backend && $(CARGO) fmt

lint: $(CARGO)
	cd frontend && flutter analyze
	cd backend && $(CARGO) fix --allow-staged

clean:
	rm -rf release
	rm -rf backend/target
	rm -rf frontend/build
	rm -rf frontend/lib/generated

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
	cd backend && ln -sf config/local.toml config.toml
	cd backend && $(CARGO) watch -x run

frontend-dev-server: frontend/lib/generated
	cd frontend && flutter run -d web-server --web-hostname=0.0.0.0 --web-port=50053

# Parallely run backend and ui: `make dev-server --jobs=2`
dev-server: /var/run/nginx.pid backend-dev-server frontend-dev-server

#####################
# Release build rules
#####################
test: builders-setup lint
	cd frontend && flutter test
	cd backend && $(CARGO) test

frontend-release: builders-setup
	cd frontend && flutter build web --release

backend-release: $(CARGO)
	cd backend && $(CARGO) build --release

release: test frontend-release backend-release
	mkdir -p release
	mkdir -p release/ui-files
	cp -r frontend-release/build/web/* release/ui-files/
	cp backend/target/release/backend release/server
	mkdir -p release/migrations
	cp -r backend/migrations/* release/migrations/
	cp backend/config/prod.toml release/config.toml
	cp nginx/prod.nginx.conf release/nginx.conf
	cp systemd.service release/systemd.service

##########################
# Release deployment rules
##########################
deployment: release
	sudo systemctl stop webnovel-reader.service || 0
	sudo mkdir -p /srv/webnovel-reader
	sudo mkdir -p /srv/webnovel-reader/var
	sudo cp release/server /srv/webnovel-reader/server
	sudo cp release/config.toml /srv/webnovel-reader/config.toml
	sudo cp -r release/ui-files /srv/webnovel-reader/
	sudo cp release/nginx.conf /etc/nginx/sites-enabled/webnovel-reader-prod.conf
	sudo cp release/systemd.service /lib/systemd/system/webnovel-reader.service
	sudo systemctl daemon-reload
	sudo systemctl restart nginx.service
	sudo systemctl restart webnovel-reader.service

.PHONY: builders-setup format lint clean backend-dev-server frontend-dev-server dev-server test frontend-release backend-release release deployment
