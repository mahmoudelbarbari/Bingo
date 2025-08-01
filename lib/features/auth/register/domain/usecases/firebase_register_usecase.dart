import 'package:bingo/features/auth/register/domain/repositories/register_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRegisterUsecase {
  final RegisterRepository _registerRepository;

  FirebaseRegisterUsecase(this._registerRepository);

  Future<UserCredential> call(String email, String password) async {
    return await _registerRepository.firebaseRegister(email, password);
  }
}
