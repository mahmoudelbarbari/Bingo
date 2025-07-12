import 'package:bingo/features/auth/register/data/datasources/register_remote_datasource.dart';
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
    return await remoteRegisterDatasource.remoteRegisterUser(name, email, password);
  }
}

