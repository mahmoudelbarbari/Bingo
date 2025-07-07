import 'package:bingo/features/login/data/datasources/login_remote_datasource.dart';
import 'package:bingo/features/login/data/reporisatory/login_reporisatory_impl.dart';
import 'package:bingo/features/login/domain/repositories/login_repository.dart';
import 'package:bingo/features/login/domain/usecases/login_usecase.dart';
import 'package:bingo/features/login/presentation/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';

import '../core/localization/localization_controller.dart';

final sl = GetIt.instance;

void init() {
  //lazy singleton will call the object when needed ONLY, the singleton when the app launched it will

  // localization
  sl.registerLazySingleton<LocalizationController>(
    () => LocalizationController(),
  );

  //-----------------------------------------------------------------------------------------
  // Login feature (injection).
  //-----------------------------------------------------------------------------------------

  //datasource
  sl.registerLazySingleton<RemoteLoginDatasource>(
    () => RemoteLoginDatasourceImpl(),
  );
  // repo
  sl.registerLazySingleton<LoginRepository>(() => LoginReporisatoryImpl(sl()));
  //usecase
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  //login cubit
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
}
