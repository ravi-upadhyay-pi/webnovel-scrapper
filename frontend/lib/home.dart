import 'package:flutter/material.dart';
import 'package:frontend/account.dart';

class HomePage extends StatelessWidget {
  final SessionHandler userAccountService;

  const HomePage(this.userAccountService, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: SizedBox(
            width: 500.0,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder(
                  future: userAccountService.getUserDetails(),
                  builder: (context, snapshot) {
                    final done =
                        snapshot.connectionState == ConnectionState.done;
                    if (done && snapshot.data != null) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () {},
                              child: const Text("Got to Webnovels"))
                        ],
                      );
                    } else if (done && snapshot.data == null) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/login");
                            },
                            child: const SizedBox(
                              width: 60,
                              child: Text(
                                "Login",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/signup");
                            },
                            child: const SizedBox(
                              width: 60,
                              child: Text(
                                "Signup",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox(
                        width: 60,
                        height: 60,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                )),
          ),
        ),
      ),
    );
  }
}
