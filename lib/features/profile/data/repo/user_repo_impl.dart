import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/profile/data/model/user_model.dart';
import 'package:bingo/features/profile/domain/entity/user.dart';
import 'package:bingo/features/profile/domain/repo/user_repo.dart';

import '../datasource/user_datasource.dart';

class UserRepoImpl implements UserRepo {
  final UserDatasource _userDatasource;

  UserRepoImpl(this._userDatasource);

  @override
  Future<UserEntity> getCurrentUSer() async {
    // TODO: implement getCurrentUSer
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> addUserAddress(AddressEntity addressEntity) async {
    return await _userDatasource.addUserAddress(
      AddressModel.fromEntity(addressEntity),
    );
  }

  @override
  Future<List<AddressEntity>> getUserAddress(String userId) async {
    return await _userDatasource.getUserAddress(userId);
  }
}
