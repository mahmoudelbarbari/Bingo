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

