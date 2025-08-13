import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/profile/domain/entity/user.dart';
import 'package:bingo/features/profile/domain/repo/user_repo.dart';

class AddUserAddressUsecase {
  final UserRepo _userRepo;

  AddUserAddressUsecase(this._userRepo);

  Future<BaseResponse> call(AddressEntity addressEntity) async =>
      _userRepo.addUserAddress(addressEntity);
}
