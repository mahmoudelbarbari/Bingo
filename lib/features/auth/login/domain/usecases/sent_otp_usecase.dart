import '../repositories/login_repository.dart';

class SentOtpUsecase {
  final LoginRepository _loginRepository;
  SentOtpUsecase(this._loginRepository);

  Future<void> call(String email) async {
    return await _loginRepository.sendOTP(email);
  }
}
