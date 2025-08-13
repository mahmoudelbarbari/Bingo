import 'package:bingo/app/di/provider_setup.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/profile/presentation/cubit/language_cubit/language_cubit.dart';
import 'package:bingo/features/profile/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:bingo/firebase_options.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bingo/app/routes/app_routes.dart';
import 'package:bingo/config/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'config/injection_container.dart' as di;
import 'core/bloc_observer/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: ".env");
  try {
    final stripeKey = dotenv.env['NEXT_PUBLIC_STRIPE_PUBLIC_KEY'];
    if (stripeKey != null && stripeKey.isNotEmpty) {
      Stripe.publishableKey = stripeKey;
      print('✅ Stripe initialized successfully');
    } else {
      print('❌ Stripe key not found in .env file');
    }
  } catch (e) {
    print('❌ Error initializing Stripe: $e');
  }
  await Stripe.instance.applySettings();
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
      providers: AppProviders.getAll(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return GetMaterialApp(
                title: 'Bingo',
                key: ValueKey(locale.languageCode),
                debugShowCheckedModeBanner: false,
                locale: locale,
                supportedLocales: const [Locale('en'), Locale('ar')],
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeMode,
                initialRoute: '/',
                routes: appRoutes,
                builder: (context, child) {
                  final locale = Localizations.localeOf(context);
                  SizeConfig.init(context);
                  return Directionality(
                    textDirection: locale.languageCode == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: child!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
