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
    super.id,
    super.streetAddress,
    super.city,
    super.state,
    super.country,
    super.zipCode,
    super.isDefault,
    super.userId,
    super.label,
    super.name,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String?,
      userId: map['userId'] as String?,
      name: map['name'] as String?,
      streetAddress: map['street'] as String?,
      city: map['city'] as String?,
      state: map['state'] as String?,
      country: map['country'] as String?,
      zipCode: map['zip'] as String?,
      isDefault: map['isDefault'] as bool?,
      label: map['label'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'isDefault': isDefault,
      'label': label,
    };
  }

  factory AddressModel.fromEntity(AddressEntity addressEntity) => AddressModel(
    label: addressEntity.label,
    city: addressEntity.city,
    country: addressEntity.country,
    isDefault: addressEntity.isDefault,
    state: addressEntity.state,
    streetAddress: addressEntity.streetAddress,
    userId: addressEntity.userId,
    zipCode: addressEntity.zipCode,
    name: addressEntity.name,
  );
}
