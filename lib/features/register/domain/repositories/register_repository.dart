import 'package:bingo/features/register/domain/entities/register_entities.dart';

abstract class RegisterRepository {
  Future<RegisterBaseResponse> remoteRegister(String name, String email, String password);
}
