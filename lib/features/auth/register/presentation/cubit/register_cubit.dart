import 'package:bingo/features/auth/login/domain/usecases/sent_otp_usecase.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/auth/register/domain/usecases/register_seller_account.dart';
import 'package:bingo/features/auth/register/domain/usecases/verify_otp_seller_usecase.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bingo/core/errors/handler_request_api.dart';
import 'package:bingo/features/auth/register/domain/usecases/register_usecase.dart';
import 'package:bingo/features/auth/register/presentation/cubit/register_state.dart';

import '../../../../../config/injection_container.dart';
import '../../../login/domain/usecases/verify_otp_usecase.dart';

class RegisterCubit extends Cubit<RegisterState> {
  late RegisterUsecase registerUsecase;
  late RegisterSellerAccount registerSellerAccount;
  late SentOtpUsecase sentOtpUsecase;
  late VerifyOtpUsecase verifyOtpUsecase;
  late VerifyOtpSellerUsecase verifyOtpSellerUsecase;

  RegisterCubit() : super(RegisterInitialState()) {
    // Initialize all use cases in the constructor
    registerUsecase = sl<RegisterUsecase>();
    registerSellerAccount = sl<RegisterSellerAccount>();
    sentOtpUsecase = sl<SentOtpUsecase>();
    verifyOtpUsecase = sl<VerifyOtpUsecase>();
    verifyOtpSellerUsecase = sl<VerifyOtpSellerUsecase>();
  }

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
          final result = await remoteRegisterUsecase.call(
            name,
            email,
            password,
          );
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

  // Send OTP to phone number
  Future<void> sendOtpToEmail(String email) async {
    sentOtpUsecase = sl();
    try {
      emit(RegisterLoadingState());
      await sentOtpUsecase.call(email);
      emit(OtpSentState(email));
    } catch (e) {
      emit(RegisterErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> verifyOtpAndRegister({
    required String name,
    required String email,
    required String password,
    required int otp,
  }) async {
    verifyOtpUsecase = sl();

    try {
      emit(OtpVerificationLoadingState());

      // Verify OTP
      final isvrified = await verifyOtpUsecase.call(name, email, password, otp);
      if (isvrified) {
        emit(
          OtpVerificationSuccessState(
            "Registration completed successfully! Welcome $name",
          ),
        );
      }

      emit(
        OtpVerificationSuccessState(
          "Registration completed successfully! Welcome $name",
        ),
      );
    } catch (e) {
      emit(OtpVerificationErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> registerSeller(
    SellerAccountModel sellerAccountModel,
    BuildContext context,
  ) async {
    final sellerRegistration = RegisterSellerAccount(sl());

    try {
      final loc = AppLocalizations.of(context)!;
      emit(RegisterLoadingState());
      handlerRequestApi(
        context: context,
        body: () async {
          final result = await sellerRegistration.call(sellerAccountModel);
          if (result.status) {
            return emit(
              SellerRegisterSuccessState(
                '${loc.welcome} ${sellerAccountModel.name}',
              ),
            );
          } else {
            return emit(
              RegisterErrorState(
                errorMessage: '${loc.error} : ${result.message}',
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(RegisterErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> verifyOtpSeller({
    required SellerAccountModel sellerAccountModel,
    required String otp,
  }) async {
    verifyOtpSellerUsecase = sl();

    try {
      emit(OtpVerificationLoadingState());

      // Verify OTP
      final isvrified = await verifyOtpSellerUsecase.call(
        sellerAccountModel,
        otp,
      );
      if (isvrified) {
        emit(
          SellerOtpVerificationSuccessState(
            "Seller Registration completed successfully! Welcome ${sellerAccountModel.name}",
          ),
        );
      }

      emit(
        SellerOtpVerificationSuccessState(
          "Seller Registration completed successfully! Welcome ${sellerAccountModel.name}",
        ),
      );
    } catch (e) {
      emit(OtpVerificationErrorState(errorMessage: e.toString()));
    }
  }
}
