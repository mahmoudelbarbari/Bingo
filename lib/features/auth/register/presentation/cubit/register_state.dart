abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final String message;

  RegisterSuccessState(this.message);
}

class RegisterErrorState extends RegisterState {
  final String errorMessage;

  RegisterErrorState({required this.errorMessage});
}

// Add new states for OTP flow
class OtpSentState extends RegisterState {
  final String email;

  OtpSentState(this.email);
}

class OtpVerificationLoadingState extends RegisterState {}

class OtpVerificationSuccessState extends RegisterState {
  final String message;

  OtpVerificationSuccessState(this.message);
}

class OtpVerificationErrorState extends RegisterState {
  final String errorMessage;

  OtpVerificationErrorState({required this.errorMessage});
}

class AccountTypeSelectionState extends RegisterState {
  final String userId;

  AccountTypeSelectionState(this.userId);
}
