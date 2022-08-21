import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

import 'account.dart';
import 'home.dart';

void main() {
  final apiClient =
      DefaultApi(ApiClient(basePath: 'http://dev.assemblyheaven.com/api'));
  final sessionHandler = SessionHandler(apiClient);
  runApp(MyApp(sessionHandler));
}

class MyApp extends StatelessWidget {
  final SessionHandler sessionHandler;

  const MyApp(this.sessionHandler, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webnovel Reader',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(sessionHandler),
        '/login': (context) => LoginPage(true, sessionHandler),
        '/signup': (context) => LoginPage(false, sessionHandler),
      },
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: false,
      ),
    );
  }
}
