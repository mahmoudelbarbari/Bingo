import 'package:bingo/features/auth/register/domain/entities/register_entities.dart';
import '../repositories/register_repository.dart';

class RegisterUsecase {
  final RegisterRepository _registerRepository;

  RegisterUsecase(this._registerRepository);

  Future<RegisterBaseResponse> call(
    String name,
    String email,
    String password,
  ) async {
    return await _registerRepository.remoteRegister(name, email, password);
  }
}
