import 'package:flutter/material.dart';

import 'package:authentication/src/providers/user_provider.dart';
import 'package:authentication/src/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  final userProvider = new UserProvider();

  // Variables del estado
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Container(child: _fieldList())));
  }

  Widget _fieldList() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        children: [
          FlutterLogo(
            size: 150,
          ),
          Divider(),
          _createUsernameField(),
          Divider(),
          _createPasswordField(),
          Divider(),
          _createLoginButton(),
          _createRegisterButton()
        ],
      ),
    );
  }

  Widget _createUsernameField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: 'Correo electrónico'),
        validator: (value) {
          if (value.length == 0)
            return 'Completa este campo';
          else if (value.length >= 128)
            return 'El valor introducido es muy largo';
          else if (!value.contains('@'))
            return 'Debe ser una dirección válida';
          else
            return null;
        },
        onChanged: (value) => setState(() {
              _email = value;
            }));
  }

  Widget _createPasswordField() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: 'Contraseña'),
        validator: (value) {
          if (value.length == 0)
            return 'Completa este campo';
          else if (value.length < 6 || value.length > 64)
            return 'Debe ser entre 8 y 64 caracteres';
          else
            return null;
        },
        onChanged: (value) => setState(() {
              _password = value;
            }));
  }

  Widget _createLoginButton() {
    return ElevatedButton(
      child: Text('INICIAR SESIÓN'),
      onPressed: () => _login(context),
    );
  }

  Widget _createRegisterButton() {
    return TextButton(
      child: Text('REGISTRARSE'),
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'register');
      },
    );
  }

  void _login(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;

    final info = await userProvider.loginUser(_email, _password);

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      showAlertDialog(
          context, 'Error', 'Nombre de usuario o contraseña incorrectos');
    }
  }
}
