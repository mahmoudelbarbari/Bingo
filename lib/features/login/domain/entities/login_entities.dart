class LoginEntities {
  final String email;
  final String password;

  LoginEntities({required this.email, required this.password});
}

class LoginBaseResponse {
  bool status;
  String message;
  String? token;

  LoginBaseResponse({required this.status, required this.message, this.token});
}
