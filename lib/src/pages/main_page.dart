import 'package:flutter/material.dart';

import 'package:authentication/src/user_preferences/user_preferences.dart';

class MainPage extends StatelessWidget {
  final _userPrefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Principal')),
        body: Center(
            child: Text(
          'Hola, ${_userPrefs.username}',
          style: TextStyle(fontSize: 20.0),
        )));
  }
}
