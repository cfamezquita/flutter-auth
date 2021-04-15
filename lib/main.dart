import 'package:flutter/material.dart';

import 'package:authentication/src/routes/routes.dart';
import 'package:authentication/src/user_preferences/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userPreferences = new UserPreferences();
  await userPreferences.initPrefs();

  runApp(AuthenticationApp());
}

class AuthenticationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: getApplicationRoutes(),
    );
  }
}
