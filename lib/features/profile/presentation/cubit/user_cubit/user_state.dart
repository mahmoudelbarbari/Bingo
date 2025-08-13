import 'package:bingo/features/profile/domain/entity/user.dart';

abstract class UserState {}

class UserInitState extends UserState {}

class UserSuccessState extends UserState {}

class UserErrorState extends UserState {
  String errMessage;

  UserErrorState(this.errMessage);
}

class UserLoadingState extends UserState {}

class UserloadedDataState extends UserState {
  final UserEntity userEntity;

  UserloadedDataState({required this.userEntity});
}

class AddUserAddressLoading extends UserState {}

class AddUserAddressSuccess extends UserState {
  String message;

  AddUserAddressSuccess(this.message);
}

class AddUserAddressError extends UserState {
  String errMessage;

  AddUserAddressError(this.errMessage);
}

class AddressLoadedState extends UserState {
  final List<AddressEntity> addressEntity;

  AddressLoadedState(this.addressEntity);
}

class AddressErrorState extends UserState {
  final String err;

  AddressErrorState(this.err);
}
