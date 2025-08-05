import '../../data/model/register_model.dart';
import '../repositories/register_repository.dart';

class VerifyOtpSellerUsecase {
  final RegisterRepository _registerRepository;

  VerifyOtpSellerUsecase(this._registerRepository);

  Future<bool> call(SellerAccountModel sellerAccountModel, String otp) async =>
      await _registerRepository.verifySellerOTP(sellerAccountModel, otp);
}
