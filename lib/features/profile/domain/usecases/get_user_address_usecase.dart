import 'package:bingo/features/profile/domain/entity/user.dart';
import 'package:bingo/features/profile/domain/repo/user_repo.dart';

class GetUserAddressUsecase {
  final UserRepo _userRepo;

  GetUserAddressUsecase(this._userRepo);

  Future<List<AddressEntity>> call(String userId) async =>
      await _userRepo.getUserAddress(userId);
}
