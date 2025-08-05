import 'package:bingo/core/localization/language_preference.dart';
import 'package:bingo/config/theme_preference.dart';
import 'package:bingo/features/auth/login/data/datasources/login_remote_datasource.dart';
import 'package:bingo/features/auth/login/data/reporisatory/login_reporisatory_impl.dart';
import 'package:bingo/features/auth/login/domain/repositories/login_repository.dart';
import 'package:bingo/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:bingo/features/auth/login/presentation/login/cubit/login_cubit.dart';
import 'package:bingo/features/auth/register/data/reporisatory/register_reporisatory_impl.dart';
import 'package:bingo/features/auth/register/domain/repositories/register_repository.dart';
import 'package:bingo/features/auth/register/domain/usecases/register_seller_account.dart';
import 'package:bingo/features/auth/register/domain/usecases/register_usecase.dart';
import 'package:bingo/features/auth/register/domain/usecases/sign_out_usecase.dart';
import 'package:bingo/features/auth/register/domain/usecases/verify_otp_seller_usecase.dart';
import 'package:bingo/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:bingo/features/cart/domain/usecase/delete_item_by_id_usecase.dart';
import 'package:bingo/features/chatbot/data/datasource/chat_bot_datasource.dart';
import 'package:bingo/features/chatbot/data/repo/chat_repo_impl.dart';
import 'package:bingo/features/chatbot/domain/repo/chat_repo.dart';
import 'package:bingo/features/chatbot/presentation/cubit/chat_bot_cubit.dart';
import 'package:bingo/features/home/data/datasource/home_datasource.dart';
import 'package:bingo/features/home/data/repo/home_repo_impl.dart';
import 'package:bingo/features/home/domain/repo/home_repo.dart';
import 'package:bingo/features/home/domain/usecase/get_all_categories_usecase.dart';
import 'package:bingo/features/home/presentaion/cubit/home_cubit.dart';
import 'package:bingo/features/product/data/datasource/product_datasource.dart';
import 'package:bingo/features/profile/data/datasource/user_datasource.dart';
import 'package:bingo/features/product/data/repo/product_repo_impl.dart';
import 'package:bingo/features/profile/data/repo/user_repo_impl.dart';
import 'package:bingo/features/product/domain/repo/product_repo.dart';
import 'package:bingo/features/profile/domain/repo/user_repo.dart';
import 'package:bingo/features/product/domain/usecase/add_product_usecase.dart';
import 'package:bingo/features/profile/domain/usecases/get_current_user_usecase.dart';
import 'package:bingo/features/product/domain/usecase/get_products_usecase.dart';
import 'package:bingo/features/product/presentation/cubit/product_cubit.dart';
import 'package:bingo/features/profile/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:bingo/features/profile/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:bingo/features/seller_onboarding/data/datasource/seller_upload_file_datasource.dart';
import 'package:bingo/features/shops/data/datasource/shop_datasource.dart';
import 'package:bingo/features/shops/data/reporisatory/shop_repo_impl.dart';
import 'package:bingo/features/shops/domain/repo/shops_repo.dart';
import 'package:bingo/features/shops/domain/usecase/add_shop_image.dart';
import 'package:bingo/features/shops/domain/usecase/add_shop_usecase.dart';
import 'package:bingo/features/shops/presentation/cubit/shop_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/database/firebase_db.dart';
import '../core/network/dio_provider.dart';
import '../features/auth/login/domain/usecases/reset_password_usecase.dart';
import '../features/auth/login/domain/usecases/sent_otp_usecase.dart';
import '../features/auth/login/domain/usecases/verify_otp_usecase.dart';
import '../features/auth/login/presentation/forget_password/cubit/forget_pass_cubit.dart';
import '../features/auth/register/data/datasources/register_remote_datasource.dart';
import '../features/cart/data/datasource/cart_datasource.dart';
import '../features/cart/data/reporisatory_imlp/cart_reporisatory_impl.dart';
import '../features/cart/domain/reporisatory/cart_reporisatory.dart';
import '../features/cart/domain/usecase/add_items_to_cart_usecase.dart';
import '../features/cart/domain/usecase/clear_cart_items_usecase.dart';
import '../features/cart/domain/usecase/get_all_cart_items_usecase.dart';
import '../features/cart/domain/usecase/view_orders_usecase.dart';
import '../features/cart/presentation/cubit/cart_cubit.dart';
import '../features/chatbot/domain/usecase/chat_message_usecase.dart';
import '../features/profile/presentation/cubit/language_cubit/language_cubit.dart';
import '../features/seller_onboarding/data/repository/seller_upload_repo_impl.dart';
import '../features/seller_onboarding/domain/repositories/upload_file_repository.dart';
import '../features/seller_onboarding/domain/usecase/seller_upload_doc_usecase.dart';
import '../features/seller_onboarding/presentation/cubit/file_upload_cubit.dart';

final sl = GetIt.instance;

void init() async {
  //lazy singleton will call the object when needed ONLY, the singleton when the app launched it will

  // firebase db
  sl.registerLazySingleton(() => FirebaseDatabseProvider());
  // localization preference and cubit
  sl.registerLazySingleton(() => LanguagePreference());
  sl.registerFactory(() => LanguageCubit(sl()));

  // dark & light theme
  sl.registerLazySingleton(() => ThemePreference());
  sl.registerFactory(() => ThemeCubit(sl()));

  // core
  sl.registerLazySingleton<Dio>(() => createDio(sl()));

  //-----------------------------------------------------------------------------------------
  // Login feature (injection).
  //-----------------------------------------------------------------------------------------

  //datasource
  sl.registerLazySingleton<RemoteLoginDatasource>(
    () => RemoteLoginDatasourceImpl(),
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
  // Register feature (injection).
  //-----------------------------------------------------------------------------------------

  // datasource register
  sl.registerLazySingleton<RemoteRegisterDatasource>(
    () => RemoteRegisterDatasourceImpl(),
  );

  // register repo
  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(sl()),
  );

  // register usecase
  sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(sl()));

  sl.registerLazySingleton<RegisterSellerAccount>(
    () => RegisterSellerAccount(sl()),
  );

  sl.registerLazySingleton<VerifyOtpSellerUsecase>(
    () => VerifyOtpSellerUsecase(sl()),
  );

  sl.registerLazySingleton<SignOutUsecase>(() => SignOutUsecase(sl()));

  // register cubit
  sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit());

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

  //-----------------------------------------------------------------------------------------
  // Profile feature (injection).
  //-----------------------------------------------------------------------------------------
  //profile datasource
  sl.registerLazySingleton<UserDatasource>(() => UserDatasourceImpl(sl()));
  sl.registerLazySingleton<ProductDatasource>(() => ProductDatasourceImpl());
  //repo
  sl.registerLazySingleton<UserRepo>(() => UserRepoImpl());
  sl.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(sl()));

  // profile usecase
  sl.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(sl()),
  );
  sl.registerLazySingleton<GetProductsUsecase>(() => GetProductsUsecase(sl()));

  sl.registerLazySingleton<AddProductUsecase>(() => AddProductUsecase(sl()));
  // profile cubit
  sl.registerLazySingleton<UserCubit>(() => UserCubit());
  sl.registerLazySingleton<ProductCubit>(() => ProductCubit());

  //-----------------------------------------------------------------------------------------
  // Cart feature (injection).
  //-----------------------------------------------------------------------------------------

  //Datasource Cart
  sl.registerLazySingleton<CartDatasourceInterface>(() => CartDatasourceImpl());

  //Repotisatory Cart
  sl.registerLazySingleton<CartReporisatoryInterface>(
    () => CartReporisatoryImpl(sl()),
  );

  //Cart usecase
  sl.registerLazySingleton<AddProductToCartUsecase>(
    () => AddProductToCartUsecase(sl<CartReporisatoryInterface>()),
  );

  sl.registerLazySingleton<GetAllCartItemsUsecase>(
    () => GetAllCartItemsUsecase(sl<CartReporisatoryInterface>()),
  );

  sl.registerLazySingleton<ViewOrderUsecase>(
    () => ViewOrderUsecase(sl<CartReporisatoryInterface>()),
  );

  sl.registerLazySingleton<ClearCartItemsUsecase>(
    () => ClearCartItemsUsecase(sl<CartReporisatoryInterface>()),
  );

  sl.registerLazySingleton<DeleteItemByIdUsecase>(
    () => DeleteItemByIdUsecase(sl<CartReporisatoryInterface>()),
  );

  //AddCartData
  //Cart Cubit
  sl.registerFactory(() => CartCubit());

  //-----------------------------------------------------------------------------------------
  // Chat bot feature (injection).
  //-----------------------------------------------------------------------------------------

  // Datasource Chat bot
  sl.registerLazySingleton<ChatBotDatasource>(
    () => ChatBotDatasourceImpl(sl()),
  );

  //Repotisatory Cart
  sl.registerLazySingleton<ChatRepository>(() => ChatRepoImpl(sl()));

  //Cart usecase
  sl.registerLazySingleton<ChatMessageUsecase>(
    () => ChatMessageUsecase(sl<ChatRepository>()),
  );

  //Chat bot Cubit
  sl.registerFactory(() => ChatCubit(sl()));

  //-----------------------------------------------------------------------------------------
  // shop feature (injection).
  //-----------------------------------------------------------------------------------------
  //datasource
  sl.registerLazySingleton<ShopDatasource>(() => ShopDatasourceImpl());

  //repo
  sl.registerLazySingleton<ShopsRepo>(() => ShopRepoImpl(sl()));

  // usecases
  sl.registerLazySingleton<AddShopUsecase>(
    () => AddShopUsecase(sl<ShopsRepo>()),
  );

  sl.registerLazySingleton<AddShopImage>(() => AddShopImage(sl<ShopsRepo>()));

  //cubit
  sl.registerLazySingleton<ShopCubit>(() => ShopCubit());

  //-----------------------------------------------------------------------------------------
  // home feature (injection).
  //-----------------------------------------------------------------------------------------
  //home datasource
  sl.registerLazySingleton<HomeDatasource>(() => HomeDatasourceImpl());

  //home repo
  sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(sl()));

  //home usecases
  sl.registerLazySingleton<GetAllCategoriesUsecase>(
    () => GetAllCategoriesUsecase(sl<HomeRepo>()),
  );

  //home cubit
  sl.registerLazySingleton<HomeCubit>(() => HomeCubit());
}
