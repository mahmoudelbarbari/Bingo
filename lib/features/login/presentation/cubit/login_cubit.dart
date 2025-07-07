import 'package:bingo/core/errors/handler_request_api.dart';
import 'package:bingo/features/login/domain/usecases/login_usecase.dart';
import 'package:bingo/features/login/presentation/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection_container.dart';

class LoginCubit extends Cubit<LoginState> {
  late LoginUsecase loginUsecase;

  LoginCubit() : super(LoginStateInt());

  Future<void> remoteLogin(
    String email,
    String password,
    BuildContext context,
  ) async {
    final remoteLoginUsecase = LoginUsecase(sl());

    try {
      emit(LoginLoadingState());
      handlerRequestApi(
        context: context,
        body: () async {
          final loggedin = await remoteLoginUsecase.call(email, password);
          if (loggedin.status) {
            return emit(LoginSuccessState("Welcome back $email"));
          } else {
            return emit(LoginErrorState(errorMessage: loggedin.message));
          }
        },
      );
    } catch (e) {
      return emit(LoginErrorState(errorMessage: e.toString()));
    }
  }
}
