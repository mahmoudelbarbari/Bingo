import 'package:bingo/features/auth/login/data/datasources/login_remote_datasource.dart';
import 'package:bingo/features/auth/login/domain/entities/login_entities.dart';
import 'package:bingo/features/auth/login/domain/repositories/login_repository.dart';

class LoginReporisatoryImpl implements LoginRepository {
  late RemoteLoginDatasource remoteLoginDatasource;

  LoginReporisatoryImpl(this.remoteLoginDatasource);

  @override
  Future<LoginBaseResponse> remoteLogin(String email, String password) async {
    return await remoteLoginDatasource.remoteLoginUser(email, password);
  }

  @override
  Future<void> resetPassword(Pattern email, String newPassword) async {
    return await remoteLoginDatasource.resetPassword(email, newPassword);
  }

  @override
  Future<void> sendOTP(String email) async {
    return await remoteLoginDatasource.sendOTP(email);
  }

  @override
  Future<void> verifyOtp(String email, String otp) async {
    return await remoteLoginDatasource.verifyOtp(email, otp);
  }
}
