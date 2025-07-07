import 'package:bingo/features/login/domain/entities/login_entities.dart';

abstract class LoginRepository {
  Future<LoginBaseResponse> remoteLogin(String email, String password);
}
