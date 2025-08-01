import '../repositories/login_repository.dart';

class VerifyOtpUsecase {
  final LoginRepository _loginRepository;

  VerifyOtpUsecase(this._loginRepository);

  Future<bool> call(String email) async {
    return await _loginRepository.verifyOtp(email);
  }
}
