import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/datasources/register_remote_datasource.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/auth/register/data/model/stripe_model.dart';
import 'package:bingo/features/auth/register/domain/entities/register_entities.dart';
import 'package:bingo/features/auth/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RemoteRegisterDatasource remoteRegisterDatasource;

  RegisterRepositoryImpl(this.remoteRegisterDatasource);

  @override
  Future<RegisterBaseResponse> remoteRegister(
    String name,
    String email,
    String password,
  ) async {
    return await remoteRegisterDatasource.remoteRegisterUser(
      name,
      email,
      password,
    );
  }

  @override
  Future<void> signOut() async {
    return await remoteRegisterDatasource.signOut();
  }

  @override
  Future<BaseResponse> registerSeller(
    SellerAccountModel sellerAccountModel,
  ) async {
    return await remoteRegisterDatasource.registerSeller(sellerAccountModel);
  }

  @override
  Future<SellerAccountModel> verifySellerOTP(
    SellerAccountModel sellerAccountModel,
    String otp,
  ) async {
    return await remoteRegisterDatasource.verifySellerOTP(
      sellerAccountModel,
      otp,
    );
  }

  @override
  Future<void> autoSellerLoginAfterVerification(
    String email,
    String password,
  ) async {
    return await remoteRegisterDatasource.autoSellerLoginAfterVerification(
      email,
      password,
    );
  }

  @override
  Future<StripeModel> createStripeConnectLink(String sellerId) async {
    return await remoteRegisterDatasource.createStripeConnectLink(sellerId);
  }
}
