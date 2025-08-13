import 'package:bingo/core/errors/handler_request_api.dart';
import 'package:bingo/features/profile/domain/usecases/add_user_address_usecase.dart';
import 'package:bingo/features/profile/domain/usecases/get_user_address_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injection_container.dart';
import '../../../../../core/service/current_user_service.dart';
import '../../../domain/entity/user.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  late AddUserAddressUsecase addUserAddressUsecase;
  late GetUserAddressUsecase getUserAddressUsecase;

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

  Future<void> addUserAddress(
    AddressEntity addressEntity,
    BuildContext context,
  ) async {
    addUserAddressUsecase = sl();
    try {
      await handlerRequestApi(
        context: context,
        body: () async {
          final addedAddressData = await addUserAddressUsecase.call(
            addressEntity,
          );
          if (addedAddressData.status) {
            emit(AddUserAddressSuccess('Address added successfully'));
          } else {
            emit(AddUserAddressError('Something went wrong'));
          }
        },
      );
    } catch (e) {
      emit(AddUserAddressError('Something went wrong ${e.toString()}'));
    }
  }

  Future<void> getUserAddress(String userId) async {
    getUserAddressUsecase = sl();
    try {
      emit(AddUserAddressLoading());
      final allAddress = await getUserAddressUsecase.call(userId);
      emit(AddressLoadedState(allAddress));
    } catch (e) {
      emit(AddressErrorState(e.toString()));
    }
  }
}
