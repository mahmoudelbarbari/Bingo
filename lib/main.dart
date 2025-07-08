import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/localization/localization_controller.dart';
import 'package:bingo/app/routes/app_routes.dart';
import 'package:bingo/config/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'config/injection_container.dart' as di;
import 'core/bloc_observer/bloc_observer.dart';
import 'features/auth/login/presentation/login/cubit/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  di.init();
  Bloc.observer = MyGlobalObserver();

  runApp(const MyApp());
  (e, s) {};
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<LoginCubit>()),
        Provider<LocalizationController>(
          create: (_) => di.sl<LocalizationController>(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Bingo',
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: appTheme,
        initialRoute: '/',
        routes: appRoutes,
        builder: (context, child) {
          final locale = Localizations.localeOf(context);
          return Directionality(
            textDirection: locale.languageCode == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: child!,
          );
        },
      ),
    );
  }
}
