import 'package:bingo/Alshimaa.dart';
import 'package:bingo/features/login/presentation/pages/login_screen.dart';
import 'package:bingo/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:bingo/features/register/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:bingo/features/onboarding/presentation/pages/onboarding_screen1.dart';
import 'package:bingo/features/onboarding/presentation/pages/onboarding_screen2.dart';
import 'package:bingo/features/onboarding/presentation/pages/onboarding_screen3.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const WelcomeSplashScreen(),
  '/onboarding1': (context) => const OnboardingScreen1(step: 0),
  '/onboarding2': (context) => const OnboardingScreen2(step: 1),
  '/onboarding3': (context) => const OnboardingScreen3(step: 2),
  '/loginScreen': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
};
