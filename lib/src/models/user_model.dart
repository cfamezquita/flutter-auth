import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String name;
  String email;
  int idNumber;
  int cellphone;

  UserModel(
      {this.id,
      this.name = '',
      this.email = '',
      this.idNumber,
      this.cellphone});

  factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        idNumber: json['idNumber'],
        cellphone: json['cellphone'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "idNumber": idNumber,
        "cellphone": cellphone,
      };
}
