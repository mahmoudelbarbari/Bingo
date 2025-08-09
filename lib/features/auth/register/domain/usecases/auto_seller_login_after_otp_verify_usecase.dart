import 'package:bingo/features/auth/register/domain/repositories/register_repository.dart';

class AutoSellerLoginAfterOtpVerifyUsecase {
  final RegisterRepository _registerRepository;

  AutoSellerLoginAfterOtpVerifyUsecase(this._registerRepository);

  Future<void> call(String email, String password) async =>
      await _registerRepository.autoSellerLoginAfterVerification(
        email,
        password,
      );
}
