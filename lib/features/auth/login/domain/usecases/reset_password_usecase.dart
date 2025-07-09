import '../repositories/login_repository.dart';

class ResetPasswordUsecase {
  final LoginRepository _loginRepository;

  ResetPasswordUsecase(this._loginRepository);

  Future<void> call(String email, String newPassword) async {
    return await _loginRepository.resetPassword(email, newPassword);
  }
}
