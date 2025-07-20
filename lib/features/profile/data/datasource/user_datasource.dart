import 'package:bingo/features/profile/data/model/user_model.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/user.dart';

abstract class UserDatasource {
  Future<UserEntity> getCurrentUser();
}

class UserDatasourceImpl implements UserDatasource {
  final Dio dio;

  UserDatasourceImpl(this.dio);

  @override
  Future<UserEntity> getCurrentUser() async {
    try {
      final response = await dio.get('/logges-in-user');
      if (response.statusCode == 200) {
        return UserModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to load user');
    }
  }
}
