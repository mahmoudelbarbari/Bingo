import 'package:bingo/features/profile/domain/entity/user.dart';

abstract class UserRepo {
  Future<UserEntity> getCurrentUSer();
}
