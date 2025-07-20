import 'package:bingo/features/profile/domain/entity/user.dart';
import 'package:bingo/features/profile/domain/repo/user_repo.dart';

class GetCurrentUserUsecase {
  final UserRepo _userRepo;

  GetCurrentUserUsecase(this._userRepo);

  Future<UserEntity> call() async {
    return await _userRepo.getCurrentUSer();
  }
}
