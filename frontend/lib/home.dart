import 'package:flutter/material.dart';
import 'package:frontend/account.dart';

class HomePage extends StatelessWidget {
  final UserAccountService userAccountService;

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Got to Login"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
