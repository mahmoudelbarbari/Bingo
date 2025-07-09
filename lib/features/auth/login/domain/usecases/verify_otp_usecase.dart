import '../repositories/login_repository.dart';

class VerifyOtpUsecase {
  final LoginRepository _loginRepository;

  VerifyOtpUsecase(this._loginRepository);

  Future<void> call(String email, String otp) async {
    return await _loginRepository.verifyOtp(email, otp);
  }
}
