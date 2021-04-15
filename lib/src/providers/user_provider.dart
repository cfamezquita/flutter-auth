import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:authentication/src/models/user_model.dart';
import 'package:authentication/src/user_preferences/user_preferences.dart';
import 'package:authentication/src/utils/utils.dart';

class UserProvider {
  // Atributos del proveedor
  final _firebaseToken = 'AIzaSyDrjvHVLKSJODsujt1qvo432O37bxb-aTM';
  final _url = '$firebaseUrl/users.json';
  final _userPrefs = new UserPreferences();

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    // Datos de autenticación
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    // Respuesta de autenticación
    final authResponse = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken'),
        body: json.encode(authData));
    Map<String, dynamic> authResponseData = json.decode(authResponse.body);
    print('Respuesta de autenticación:');
    print(authResponseData);

    if (authResponseData.containsKey('idToken')) {
      // Respuesta de datos de usuario
      final userResponse = await http.get(Uri.parse(_url));
      final Map<String, dynamic> userResponseData =
          json.decode(userResponse.body);
      print('Respuesta de datos de usuario:');
      print(userResponseData);

      // Comprobar si datos de usuario existen
      bool _userFound = false;
      if (userResponseData != null) {
        userResponseData.forEach((key, jsonUser) {
          if (jsonUser["email"] == email) {
            print('Usuario con email: $email');
            _userPrefs.tokenId = authResponseData['idToken'];
            _userPrefs.username = jsonUser['name'];
            _userFound = true;
            return;
          }
        });
      }
      return {'ok': _userFound, 'token': authResponseData['idToken']};
    } else {
      return {'ok': false, 'error': authResponseData['error']};
    }
  }

  Future<Map<String, dynamic>> registerUser(
      UserModel user, String password) async {
    // Datos de autenticación
    final authData = {
      'email': user.email,
      'password': password,
      'returnSecureToken': true
    };

    // Respuesta de autenticación
    final authResponse = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'),
        body: json.encode(authData));
    Map<String, dynamic> authResponseData = json.decode(authResponse.body);
    print('Respuesta de autenticación:');
    print(authResponseData);

    if (authResponseData.containsKey('idToken')) {
      // Respuesta de datos de usuario
      final userResponse =
          await http.post(Uri.parse(_url), body: userModelToJson(user));
      final userResponseData = json.decode(userResponse.body);
      print('Respuesta de datos de usuario:');
      print(userResponseData);

      // Cargar datos en preferencias de usuario
      _userPrefs.tokenId = authResponseData['idToken'];
      _userPrefs.username = user.name;
      return {'ok': true, 'token': authResponseData['idToken']};
    } else {
      return {'ok': false, 'error': authResponseData['error']};
    }
  }
}
