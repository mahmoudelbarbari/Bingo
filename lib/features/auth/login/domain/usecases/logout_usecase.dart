import 'package:bingo/features/auth/login/domain/repositories/login_repository.dart';

import '../../../../../core/util/base_response.dart';

class LogoutUsecase {
  final LoginRepository _loginRepository;

  LogoutUsecase(this._loginRepository);

  Future<BaseResponse> call(bool isSeller) async {
    return await _loginRepository.logout(isSeller);
  }
}
