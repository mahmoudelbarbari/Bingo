class UserEntity {
  final String? idUser;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? country;
  final String? role;
  final AddressEntity? address;

  UserEntity({
    this.idUser,
    this.name,
    this.email,
    this.phoneNumber,
    this.country,
    this.role,
    this.address,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
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
}

class AddressEntity {
  final String? id;
  final String? userId;
  final String? name;
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? country;
  final String? zipCode;
  final bool? isDefault;
  final String? label;
  AddressEntity({
    this.id,
    this.userId,
    this.name,
    this.streetAddress,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.isDefault,
    this.label,
  });
}
