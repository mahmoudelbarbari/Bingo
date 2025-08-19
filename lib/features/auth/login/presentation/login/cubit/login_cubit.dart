import 'package:bingo/core/errors/handler_request_api.dart';
import 'package:bingo/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:bingo/features/auth/login/domain/usecases/logout_usecase.dart';
import 'package:bingo/features/auth/login/presentation/login/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injection_container.dart';

class LoginCubit extends Cubit<LoginState> {
  late LoginUsecase loginUsecase;
  late LogoutUsecase logoutUsecase;

  LoginCubit() : super(LoginStateInt());

  Future<void> remoteLogin(
    String email,
    String password,
    BuildContext context, {
    required bool isSeller,
  }) async {
    loginUsecase = sl();

    try {
      emit(LoginLoadingState());
      await handlerRequestApi(
        context: context,
        body: () async {
          final loggedin = await loginUsecase.call(email, password, isSeller);
          if (loggedin.status) {
            emit(LoginSuccessState("Welcome back $email"));
          } else {
            emit(LoginErrorState(errorMessage: loggedin.message));
          }
        },
      );
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> logout(BuildContext context, {required bool isSeller}) async {
    logoutUsecase = sl();
    try {
      emit(LogoutLoadingState());
      await handlerRequestApi(
        context: context,
        body: () async {
          final loggedout = await logoutUsecase.call(isSeller);
          if (loggedout.status) {
            emit(LogoutSuccessState("Logged out successfully"));
          } else {
            emit(LogoutErrorState(errorMessage: loggedout.message));
          }
        },
      );
    } catch (e) {
      emit(LogoutErrorState(errorMessage: e.toString()));
    }
  }
}
