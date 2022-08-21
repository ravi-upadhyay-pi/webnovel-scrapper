import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class SessionHandler {
  late final DefaultApi apiClient;
  User? userDetails;

  SessionHandler(this.apiClient) {}

  Future<User?> getUserDetails() async {
    if (userDetails == null) {
      return null;
    }
    return await apiClient
        .userGet(GetUserRequest(token: userDetails!.authenticationToken));
  }

  void login(String username, String password) async {
    userDetails = await apiClient.createAuthenticationToken(
        UserCredential(userName: username, password: password));
  }
}

class LoginPage extends StatefulWidget {
  final bool isLogin; // will be false for registration.
  final SessionHandler sessionHandler;

  const LoginPage(this.isLogin, this.sessionHandler, {Key? key})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submit() async {
    final username = userNameController.text;
    final password = passwordController.text;
    widget.sessionHandler.login(username, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.isLogin ? 'Login' : 'Signup',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: userNameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: submit,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
