import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../config/injection_container.dart' as di;
import '../../core/localization/localization_controller.dart';
import '../../features/auth/login/presentation/forget_password/cubit/forget_pass_cubit.dart';
import '../../features/auth/login/presentation/login/cubit/login_cubit.dart';

class AppProviders {
  static List<SingleChildWidget> getAll() {
    return [
      BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
      BlocProvider<ForgotPasswordCubit>(
        create: (_) => di.sl<ForgotPasswordCubit>(),
      ),
      Provider<LocalizationController>(
        create: (_) => di.sl<LocalizationController>(),
      ),
    ];
  }
}
