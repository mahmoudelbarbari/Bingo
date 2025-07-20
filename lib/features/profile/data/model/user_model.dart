import '../../domain/entity/user.dart';

class UserModel extends UserEntity {
  UserModel({
    super.idUser,
    super.name,
    super.email,
    super.phoneNumber,
    super.country,
    super.role,
    super.address,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      idUser: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      country: map['country'],
      role: map['role'],
      address: map['address'] != null
          ? AddressEntity(
              streetAddress: map['address']['streetAddress'],
              city: map['address']['city'],
              state: map['address']['state'],
              country: map['address']['country'],
              zipCode: map['address']['zipCode'],
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idUser,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'country': country,
      'role': role,
      'address': address != null
          ? {
              'streetAddress': address!.streetAddress,
              'city': address!.city,
              'state': address!.state,
              'country': address!.country,
              'zipCode': address!.zipCode,
            }
          : null,
    };
  }
}

class AddressModel extends AddressEntity {
  AddressModel({
    super.streetAddress,
    super.city,
    super.state,
    super.country,
    super.zipCode,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      streetAddress: map['streetAddress'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      zipCode: map['zipCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
    };
  }
}
