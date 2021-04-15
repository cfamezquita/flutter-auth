import 'package:flutter/material.dart';

import 'package:authentication/src/models/user_model.dart';
import 'package:authentication/src/providers/user_provider.dart';
import 'package:authentication/src/utils/utils.dart' as utils;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = new GlobalKey<FormState>();
  final userProvider = new UserProvider();

  // Password es almacenado por separado de los demás datos del usuario para
  // evitar ser modificado por cualquiera con acceso a la base de datos
  String _password = '';
  UserModel user = new UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Registrarse')),
        body: Center(child: _fieldList()));
  }

  Widget _fieldList() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          _createNameField(),
          Divider(),
          _createEmailField(),
          Divider(),
          _createNidField(),
          Divider(),
          _createCellField(),
          Divider(),
          _createPasswordField(),
          Divider(),
          _createRegisterButton(),
          _createBackButton()
        ],
      ),
    );
  }

  Widget _createNameField() {
    return TextFormField(
        keyboardType: TextInputType.name,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: 'Nombre'),
        validator: (value) {
          if (value.length == 0)
            return 'Completa este campo';
          else if (value.length >= 128)
            return 'El valor introducido es muy largo';
          else
            return null;
        },
        onChanged: (value) => setState(() {
              user.name = value;
            }));
  }

  Widget _createEmailField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: 'Correo'),
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
              user.email = value;
            }));
  }

  Widget _createNidField() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Número de Identificación'),
        validator: (value) {
          if (value.length == 0)
            return 'Completa este campo';
          else if (!utils.isNumeric(value))
            return 'Debe ser un número';
          else
            return null;
        },
        onChanged: (value) => setState(() {
              user.idNumber = int.parse(value);
            }));
  }

  Widget _createCellField() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: 'Celular'),
        validator: (value) {
          if (value.length == 0)
            return 'Completa este campo';
          else if (!utils.isNumeric(value))
            return 'Debe ser un número';
          else
            return null;
        },
        onChanged: (value) => setState(() {
              user.cellphone = int.parse(value);
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

  Widget _createRegisterButton() {
    return ElevatedButton(
      child: Text('REGISTRARSE'),
      onPressed: () => _register(context),
    );
  }

  Widget _createBackButton() {
    return TextButton(
      child: Text('ATRÁS'),
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'register');
      },
    );
  }

  void _register(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;

    final info = await userProvider.registerUser(user, _password);

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      utils.showAlertDialog(
          context, 'Error', 'Se ha producido un error al registrar el usuario');
    }
  }
}
