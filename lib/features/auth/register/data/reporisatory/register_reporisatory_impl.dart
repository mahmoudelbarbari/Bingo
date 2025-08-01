import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/datasources/register_remote_datasource.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/auth/register/domain/entities/register_entities.dart';
import 'package:bingo/features/auth/register/domain/repositories/register_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Future<BaseResponse> addSellerData(
    SellerAccountModel sellerAccountModel,
  ) async {
    return remoteRegisterDatasource.addSellerData(sellerAccountModel);
  }

  @override
  Future<UserCredential> firebaseRegister(String email, String password) async {
    return await remoteRegisterDatasource.firebaseRegister(email, password);
  }

  @override
  Future<void> signOut() async {
    return await remoteRegisterDatasource.signOut();
  }
}
