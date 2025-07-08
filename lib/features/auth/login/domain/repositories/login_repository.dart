import 'package:bingo/features/auth/login/domain/entities/login_entities.dart';

abstract class LoginRepository {
  Future<LoginBaseResponse> remoteLogin(String email, String password);
}
