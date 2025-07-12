import 'package:bingo/features/auth/login/domain/entities/login_entities.dart';

class LoginModel extends LoginEntities {
  LoginModel({required super.email, required super.password});

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }

  factory LoginModel.fromMap(map) {
    return LoginModel(email: map['email'], password: map['password']);
  }
}
