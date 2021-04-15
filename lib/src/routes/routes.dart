import 'package:flutter/material.dart';

import 'package:authentication/src/pages/login_page.dart';
import 'package:authentication/src/pages/main_page.dart';
import 'package:authentication/src/pages/register_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => MainPage(),
    'login': (BuildContext context) => LoginPage(),
    'register': (BuildContext context) => RegisterPage()
  };
}
