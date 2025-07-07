abstract class LoginState {}

class LoginStateInt extends LoginState {}

class LoginSuccessState extends LoginState {
  String message;

  LoginSuccessState(this.message);
}

class LogoutSuccessState extends LoginState {
  LogoutSuccessState(logedOut);
}

class LoginErrorState extends LoginState {
  String errorMessage;

  LoginErrorState({required this.errorMessage});
}

class LoginLoadingState extends LoginState {}

class LogoutLoadingState extends LoginState {}
