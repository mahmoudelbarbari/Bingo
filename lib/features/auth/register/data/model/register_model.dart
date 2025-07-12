import 'package:bingo/features/auth/register/domain/entities/register_entities.dart';

class RegisterModel extends RegisterEntities {
  RegisterModel({
    required super.name,
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory RegisterModel.fromMap(map) {
    return RegisterModel(
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}

