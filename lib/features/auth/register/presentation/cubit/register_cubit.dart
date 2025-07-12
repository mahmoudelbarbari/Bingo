import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bingo/core/errors/handler_request_api.dart';
import 'package:bingo/features/auth/register/domain/usecases/register_usecase.dart';
import 'package:bingo/features/auth/register/presentation/cubit/register_state.dart';

import '../../../../../config/injection_container.dart';

class RegisterCubit extends Cubit<RegisterState> {
  late RegisterUsecase registerUsecase;

  RegisterCubit() : super(RegisterInitialState());

  Future<void> registerUser(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    final remoteRegisterUsecase = RegisterUsecase(sl());

    try {
      emit(RegisterLoadingState());
      handlerRequestApi(
        context: context,
        body: () async {
          final result = await remoteRegisterUsecase.call(name, email, password);
          if (result.status) {
            return emit(RegisterSuccessState("Welcome $name"));
          } else {
            return emit(RegisterErrorState(errorMessage: result.message));
          }
        },
      );
    } catch (e) {
      emit(RegisterErrorState(errorMessage: e.toString()));
    }
  }
}

