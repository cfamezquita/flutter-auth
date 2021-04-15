import 'package:flutter/material.dart';

final firebaseUrl =
    'https://flutter-authentication-a4327-default-rtdb.firebaseio.com/';

bool isNumeric(String str) {
  if (str.isEmpty) return false;
  return (num.tryParse(str) != null) ? true : false;
}

void showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
