import 'package:bingo/features/auth/login/domain/entities/login_entities.dart';

import '../repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository _loginRepository;
  LoginUsecase(this._loginRepository);

  Future<LoginBaseResponse> call(String email, String password) async {
    return await _loginRepository.remoteLogin(email, password);
  }
}
