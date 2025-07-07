import 'package:bingo/features/login/data/datasources/login_remote_datasource.dart';
import 'package:bingo/features/login/domain/entities/login_entities.dart';
import 'package:bingo/features/login/domain/repositories/login_repository.dart';

class LoginReporisatoryImpl implements LoginRepository {
  late RemoteLoginDatasource remoteLoginDatasource;

  LoginReporisatoryImpl(this.remoteLoginDatasource);

  @override
  Future<LoginBaseResponse> remoteLogin(String email, String password) async {
    return await remoteLoginDatasource.remoteLoginUser(email, password);
  }
}
