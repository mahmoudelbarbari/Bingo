import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/service/current_user_service.dart';
import '../../../domain/entity/user.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitState());

  Future<void> loadCurrentUser() async {
    try {
      emit(UserLoadingState());
      final user = await CurrentUserService.getCurrentUser();

      if (user != null) {
        // Convert map to your UserEntity model
        final userEntity = UserEntity.fromMap(user);
        emit(UserloadedDataState(userEntity: userEntity));
      } else {
        emit(UserErrorState('User not authenticated'));
      }
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<bool> isUserSeller() async {
    return await CurrentUserService.isCurrentUserSeller();
  }

  Future<String?> getCurrentUserId() async {
    return await CurrentUserService.getCurrentUserId();
  }

  Future<String?> getSellerId() async {
    return await CurrentUserService.getCurrentSellerId();
  }
}
