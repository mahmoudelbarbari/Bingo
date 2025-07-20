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
