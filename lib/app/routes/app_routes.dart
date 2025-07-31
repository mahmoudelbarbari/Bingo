import 'package:bingo/features/auth/login/presentation/login/pages/login_screen.dart';
import 'package:bingo/features/auth/login/presentation/otp_verification/otp_verification_screen.dart';
import 'package:bingo/features/auth/login/presentation/create_new_password/create_new_pass_screen.dart';
import 'package:bingo/features/auth/register/presentation/pages/register_screen.dart';
import 'package:bingo/features/home/presentaion/pages/product_details.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/bottom_nav_bar_widget.dart';
import 'package:bingo/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:bingo/features/profile/presentation/pages/add_address_page.dart';
import 'package:bingo/features/profile/presentation/pages/settings_page.dart';
import 'package:bingo/features/profile/presentation/pages/saved_address_page.dart';
import 'package:bingo/features/seller_onboarding/presentation/pages/file_upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:bingo/features/onboarding/presentation/pages/onboarding_screen1.dart';
import 'package:bingo/features/onboarding/presentation/pages/onboarding_screen2.dart';
import 'package:bingo/features/onboarding/presentation/pages/onboarding_screen3.dart';

import '../../features/auth/login/presentation/forget_password/pages/forget_pass_screen.dart';
import '../../features/chatbot/presentation/pages/chat_bot_page.dart';
import '../../features/profile/domain/entity/product.dart';
import '../../features/seller_onboarding/presentation/pages/seller_onboarding_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const WelcomeSplashScreen(),
  '/onboarding1': (context) => const OnboardingScreen1(step: 0),
  '/onboarding2': (context) => const OnboardingScreen2(step: 1),
  '/onboarding3': (context) => const OnboardingScreen3(step: 2),
  '/loginScreen': (context) => const LoginScreen(),
  '/forgetPassword': (context) => const ForgetPassScreen(),
  '/createPassword': (context) => const CreateNewPasswordScreen(),
  '/register': (context) => const RegisterScreen(),
  '/otpVerify': (context) => const OtpVerificationScreen(),
  '/sellerOnboarding': (context) => const SellerOnboardingScreen(),
  '/fileUploadScreen': (context) => const FileUploadSection(),
  '/bottomNavBar': (context) => const BottomNavBarWidget(),
  '/product-details': (context) => ProductDetails(
    product: ModalRoute.of(context)!.settings.arguments as ProductEntity,
  ),
  '/chatBot': (context) => const ChatBotPage(),
  '/settingScreen': (context) => const SettingsPage(),
  '/savedAddressScreen': (context) => SavedAddressPage(),
  '/addAddressScreen': (context) => AddAddressPage(),
};
