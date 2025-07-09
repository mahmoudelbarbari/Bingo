// presentation/cubit/forgot_password_cubit.dart
import 'package:bingo/features/auth/login/presentation/forget_password/cubit/forget_pass_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injection_container.dart';
import '../../../domain/usecases/reset_password_usecase.dart';
import '../../../domain/usecases/sent_otp_usecase.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  late SentOtpUsecase sendOtpUseCase;
  late VerifyOtpUsecase verifyOtpUseCase;
  late ResetPasswordUsecase resetPasswordUseCase;

  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  String? email;

  Future<void> sendOtp(String email) async {
    emit(ForgotPasswordLoading());
    sendOtpUseCase = sl();
    try {
      this.email = email;
      await sendOtpUseCase.call(email);
      emit(ForgotPasswordOtpSent());
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(ForgotPasswordLoading());
    try {
      verifyOtpUseCase = sl();
      await verifyOtpUseCase.call(email!, otp);
      emit(ForgotPasswordOtpVerified());
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }

  Future<void> resetPassword(String newPassword) async {
    emit(ForgotPasswordLoading());
    try {
      resetPasswordUseCase = sl();
      await resetPasswordUseCase.call(email!, newPassword);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }
}
