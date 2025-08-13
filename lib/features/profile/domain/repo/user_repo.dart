import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/profile/domain/entity/user.dart';

abstract class UserRepo {
  Future<UserEntity> getCurrentUSer();
  Future<BaseResponse> addUserAddress(AddressEntity addressEntity);
  Future<List<AddressEntity>> getUserAddress(String userId);
}
