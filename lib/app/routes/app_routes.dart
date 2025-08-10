import 'package:bingo/features/auth/login/presentation/login/pages/login_screen.dart';
import 'package:bingo/features/auth/login/presentation/otp_verification/otp_verification_screen.dart';
import 'package:bingo/features/auth/login/presentation/create_new_password/create_new_pass_screen.dart';
import 'package:bingo/features/auth/register/presentation/pages/account_type_page.dart';
import 'package:bingo/features/auth/register/presentation/pages/register_screen.dart';
import 'package:bingo/features/shops/presentation/pages/add_shop_page.dart';
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

import '../../core/helper/token_storage.dart';
import '../../features/auth/login/presentation/forget_password/pages/forget_pass_screen.dart';
import '../../features/chatbot/presentation/pages/chat_bot_page.dart';
import '../../features/product/domain/entity/product.dart';
import '../../features/product/presentation/pages/add_product_page.dart';
import '../../features/seller_onboarding/presentation/pages/seller_onboarding_screen.dart';
import '../../features/seller_profile/presentation/pages/seller_profile_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const WelcomeSplashScreen(),
  '/onboarding1': (context) => const OnboardingScreen1(step: 0),
  '/onboarding2': (context) => const OnboardingScreen2(step: 1),
  '/onboarding3': (context) => const OnboardingScreen3(step: 2),
  '/loginScreen': (context) => const LoginScreen(),
  '/forgetPassword': (context) => const ForgetPassScreen(),
  '/createPassword': (context) => const CreateNewPasswordScreen(),
  '/register': (context) => RegisterScreen(
    selectType: ModalRoute.of(context)!.settings.arguments as String,
  ),
  '/otpVerify': (context) => OtpVerificationScreen(
    name: ModalRoute.of(context)!.settings.arguments as String,
    email: ModalRoute.of(context)!.settings.arguments as String,
    password: ModalRoute.of(context)!.settings.arguments as String,
  ),
  '/accountType': (context) => const AccountTypePage(),
  '/sellerOnboarding': (context) => const SellerOnboardingScreen(),
  '/fileUploadScreen': (context) => const FileUploadSection(),
  '/bottomNavBar': (context) => const BottomNavBarWidget(),
  '/product-details': (context) => ProductDetails(
    product: ModalRoute.of(context)!.settings.arguments as ProductEntity,
  ),
  '/chatBot': (context) => const ChatBotPage(),
  '/settingScreen': (context) => const SettingsPage(),
  '/savedAddressScreen': (context) => SavedAddressPage(),
  '/addAddressScreen': (context) => const AddAddressPage(),
  '/addSellerShop': (context) => AddShopPage(),
  '/add-product': (context) => const AddProductPage(),
  '/seller-profile': (context) {
    // Get the current seller's ID from storage
    return FutureBuilder<String?>(
      future: TokenStorage.getSellerId(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          return SellerProfileScreen(sellerId: snapshot.data!);
        } else {
          // Show error instead of passing empty string
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Seller ID not found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Please login again as a seller'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/loginScreen'),
                    child: const Text('Go to Login'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  },
};
