import 'package:bingo/features/auth/register/domain/repositories/register_repository.dart';

class SignOutUsecase {
  final RegisterRepository _registerRepository;
  SignOutUsecase(this._registerRepository);

  Future<void> call() async => await _registerRepository.signOut();
}
