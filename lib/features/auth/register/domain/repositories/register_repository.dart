import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/auth/register/data/model/stripe_model.dart';
import 'package:bingo/features/auth/register/domain/entities/register_entities.dart';

abstract class RegisterRepository {
  Future<RegisterBaseResponse> remoteRegister(
    String name,
    String email,
    String password,
  );
  Future<BaseResponse> registerSeller(SellerAccountModel sellerAccountModel);
  Future<SellerAccountModel> verifySellerOTP(
    SellerAccountModel sellerAccountModel,
    String otp,
  );

  Future<void> autoSellerLoginAfterVerification(String email, String password);

  Future<StripeModel> createStripeConnectLink(String sellerId);
  Future<void> signOut();
}
