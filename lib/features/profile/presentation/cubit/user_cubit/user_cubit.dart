import 'package:bingo/features/profile/domain/usecases/get_current_user_usecase.dart';
import 'package:bingo/features/profile/presentation/cubit/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injection_container.dart';

class UserCubit extends Cubit<UserState> {
  late GetCurrentUserUsecase getCurrentUserUsecase;

  UserCubit() : super(UserInitState());

  Future<void> getCurrentUser() async {
    try {
      emit(UserLoadingState());
      getCurrentUserUsecase = sl();
      final currentUser = await getCurrentUserUsecase.call();
      emit(UserloadedDataState(userEntity: currentUser));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
