class RegisterEntities {
  final String name;
  final String email;
  final String password;

  RegisterEntities({
    required this.name,
    required this.email,
    required this.password,
  });
}

class RegisterBaseResponse {
  final bool status;
  final String message;
  final String? token;

  RegisterBaseResponse({
    required this.status,
    required this.message,
    this.token,
  });
}

class Account {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? phoneNum;
  final String? country;
  final String? stripId;

  Account({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phoneNum,
    this.country,
    this.stripId,
  });
}

// Add new entity for OTP verification
class OtpVerificationEntities {
  final String phoneNumber;
  final String otpCode;

  OtpVerificationEntities({required this.phoneNumber, required this.otpCode});
}

class OtpVerificationResponse {
  final bool status;
  final String message;
  final String? userId;

  OtpVerificationResponse({
    required this.status,
    required this.message,
    this.userId,
  });
}

class SellerAccount extends Account {
  SellerAccount({
    super.id,
    super.name,
    super.email,
    super.password,
    super.phoneNum,
    super.country,
    super.stripId,
  });
}
