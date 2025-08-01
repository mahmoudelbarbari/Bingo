import 'package:bingo/features/auth/register/domain/entities/register_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterModel extends RegisterEntities {
  RegisterModel({
    required super.name,
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'password': password};
  }

  factory RegisterModel.fromMap(map) {
    return RegisterModel(
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}

class SellerAccountModel extends SellerAccount {
  SellerAccountModel({
    super.id,
    super.name,
    super.email,
    super.password,
    super.country,
    super.phoneNum,
    super.stripId,
  });

  factory SellerAccountModel.fromJson(Map<String, dynamic> json) {
    return SellerAccountModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      country: json['country'] as String?,
      phoneNum: json['phoneNum'] as String?,
      stripId: json['stripId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'country': country,
      'phoneNum': phoneNum,
      'stripId': stripId,
      // ID is usually managed by Firestore document itself, so excluded
    };
  }

  factory SellerAccountModel.fromSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();

    return SellerAccountModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      country: data['country'] ?? '',
      phoneNum: data['phoneNum'] ?? '',
      stripId: data['stripId'] ?? '',
    );
  }
}
