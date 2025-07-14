import 'package:bingo/features/auth/login/data/datasources/login_remote_datasource.dart';
import 'package:bingo/features/auth/login/data/reporisatory/login_reporisatory_impl.dart';
import 'package:bingo/features/auth/login/domain/repositories/login_repository.dart';
import 'package:bingo/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:bingo/features/auth/login/presentation/login/cubit/login_cubit.dart';
import 'package:bingo/features/seller_onboarding/data/datasource/seller_upload_file_datasource.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/localization/localization_controller.dart';
import '../core/network/dio_provider.dart';
import '../features/auth/login/domain/usecases/reset_password_usecase.dart';
import '../features/auth/login/domain/usecases/sent_otp_usecase.dart';
import '../features/auth/login/domain/usecases/verify_otp_usecase.dart';
import '../features/auth/login/presentation/forget_password/cubit/forget_pass_cubit.dart';
import '../features/seller_onboarding/data/repository/seller_upload_repo_impl.dart';
import '../features/seller_onboarding/domain/repositories/upload_file_repository.dart';
import '../features/seller_onboarding/domain/usecase/seller_upload_doc_usecase.dart';
import '../features/seller_onboarding/presentation/cubit/file_upload_cubit.dart';

final sl = GetIt.instance;

void init() {
  //lazy singleton will call the object when needed ONLY, the singleton when the app launched it will

  // localization
  sl.registerLazySingleton<LocalizationController>(
    () => LocalizationController(),
  );

  // core
  sl.registerLazySingleton<Dio>(() => createDio());

  //-----------------------------------------------------------------------------------------
  // Login feature (injection).
  //-----------------------------------------------------------------------------------------

  //datasource
  sl.registerLazySingleton<RemoteLoginDatasource>(
    () => RemoteLoginDatasourceImpl(sl()),
  );
  // repo
  sl.registerLazySingleton<LoginRepository>(() => LoginReporisatoryImpl(sl()));

  // login usecase
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  // reset password usecase
  sl.registerLazySingleton<ResetPasswordUsecase>(
    () => ResetPasswordUsecase(sl()),
  );
  // send otp usecase
  sl.registerLazySingleton<SentOtpUsecase>(() => SentOtpUsecase(sl()));
  // verify otp usecase
  sl.registerLazySingleton<VerifyOtpUsecase>(() => VerifyOtpUsecase(sl()));

  //login cubit && reset_pass and sendverify__OTP cubit
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
  sl.registerLazySingleton<ForgotPasswordCubit>(() => ForgotPasswordCubit());

  //-----------------------------------------------------------------------------------------
  // Upload files feature (injection).
  //-----------------------------------------------------------------------------------------
  // file upload datasource
  sl.registerLazySingleton<SellerUploadFileDatasource>(
    () => SellerUploadFileDatasourceImpl(sl()),
  );
  // file upload repo
  sl.registerLazySingleton<UploadFileRepository>(
    () => SellerUploadRepoImpl(sl()),
  );
  // file upload usecase
  sl.registerLazySingleton<SellerUploadDocUsecase>(
    () => SellerUploadDocUsecase(sl()),
  );
  // file upload cubit
  sl.registerLazySingleton<FileUploadCubit>(() => FileUploadCubit(sl()));
}
