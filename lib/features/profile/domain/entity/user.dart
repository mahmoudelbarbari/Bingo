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
}

class AddressEntity {
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? country;
  final int? zipCode;

  AddressEntity({
    this.streetAddress,
    this.city,
    this.state,
    this.country,
    this.zipCode,
  });
}
