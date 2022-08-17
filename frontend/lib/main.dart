import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'account.dart';
import 'home.dart';
import 'login.dart';

void main() {
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }
  final userAccountService = UserAccountService();
  runApp(MyApp(userAccountService));
}

class MyApp extends StatelessWidget {
  final UserAccountService userAccountService;

  const MyApp(this.userAccountService, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webnovel Reader',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(userAccountService),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const LoginPage(),
      },
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: false,
      ),
    );
  }
}
