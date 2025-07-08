import 'package:bingo/features/auth/login/data/datasources/login_remote_datasource.dart';
import 'package:bingo/features/auth/login/data/reporisatory/login_reporisatory_impl.dart';
import 'package:bingo/features/auth/login/domain/repositories/login_repository.dart';
import 'package:bingo/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:bingo/features/auth/login/presentation/login/cubit/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/localization/localization_controller.dart';
import '../core/network/dio_provider.dart';

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
  //usecase
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  //login cubit
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
}
