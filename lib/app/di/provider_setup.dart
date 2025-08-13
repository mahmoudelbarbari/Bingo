import 'package:bingo/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:bingo/features/chatbot/presentation/cubit/chat_bot_cubit.dart';
import 'package:bingo/features/home/presentaion/cubit/home_cubit.dart';
import 'package:bingo/features/product/presentation/cubit/product_cubit.dart';
import 'package:bingo/features/profile/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:bingo/features/seller_profile/presentation/cubit/seller_profile_cubit.dart';
import 'package:bingo/features/shops/presentation/cubit/shop_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import '../../config/injection_container.dart' as di;
import '../../features/auth/login/presentation/forget_password/cubit/forget_pass_cubit.dart';
import '../../features/auth/login/presentation/login/cubit/login_cubit.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/payment/presentation/cubit/payment_cubit.dart';
import '../../features/profile/presentation/cubit/language_cubit/language_cubit.dart';
import '../../features/profile/presentation/cubit/theme_cubit/theme_cubit.dart';
import '../../features/seller_onboarding/presentation/cubit/file_upload_cubit.dart';

class AppProviders {
  static List<SingleChildWidget> getAll() {
    return [
      BlocProvider<LanguageCubit>(create: (_) => di.sl<LanguageCubit>()),
      BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
      BlocProvider<UserCubit>(
        create: (_) => di.sl<UserCubit>()..getCurrentUserId(),
      ),
      BlocProvider<ForgotPasswordCubit>(
        create: (_) => di.sl<ForgotPasswordCubit>(),
      ),
      BlocProvider<FileUploadCubit>(create: (_) => di.sl<FileUploadCubit>()),

      BlocProvider<ThemeCubit>(create: (_) => di.sl<ThemeCubit>()),
      BlocProvider<ProductCubit>(
        create: (_) => di.sl<ProductCubit>()..getAllProduct(),
      ),
      BlocProvider(create: (_) => di.sl<CartCubit>()..getAllCartItems()),

      BlocProvider<ChatCubit>(create: (_) => di.sl<ChatCubit>()),

      BlocProvider<RegisterCubit>(create: (_) => di.sl<RegisterCubit>()),

      BlocProvider<ShopCubit>(create: (_) => di.sl<ShopCubit>()),

      BlocProvider<HomeCubit>(create: (_) => di.sl<HomeCubit>()),
      BlocProvider<SellerProfileCubit>(
        create: (_) => di.sl<SellerProfileCubit>(),
      ),
      BlocProvider<PaymentCubit>(create: (_) => di.sl<PaymentCubit>()),
    ];
  }
}
