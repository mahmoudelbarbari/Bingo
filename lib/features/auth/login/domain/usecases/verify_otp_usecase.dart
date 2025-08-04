import '../repositories/login_repository.dart';

class VerifyOtpUsecase {
  final LoginRepository _loginRepository;

  VerifyOtpUsecase(this._loginRepository);

  Future<bool> call(String name, String email, String password, int otp) async {
    return await _loginRepository.verifyOtp(name, email, password, otp);
  }
}
