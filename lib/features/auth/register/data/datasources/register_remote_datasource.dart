import 'package:bingo/core/network/dio_provider.dart';
import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/auth/register/data/model/stripe_model.dart';
import 'package:bingo/features/auth/register/domain/entities/register_entities.dart';
import 'package:dio/dio.dart';

import '../../../../../core/helper/token_storage.dart';

abstract class RemoteRegisterDatasource {
  Future<RegisterBaseResponse> remoteRegisterUser(
    String name,
    String email,
    String password,
  );

  Future<BaseResponse> registerSeller(SellerAccountModel sellerAccountModel);
  Future<SellerAccountModel> verifySellerOTP(
    SellerAccountModel sellerAccountModel,
    String otp,
  );
  Future<void> autoSellerLoginAfterVerification(String email, String password);
  Future<StripeModel> createStripeConnectLink(String sellerId);
  Future<void> signOut();
}

class RemoteRegisterDatasourceImpl implements RemoteRegisterDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.auth);

  RemoteRegisterDatasourceImpl();

  @override
  Future<RegisterBaseResponse> remoteRegisterUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.post(
        'user-registration',
        data: {'name': name, 'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        return RegisterBaseResponse(
          status: true,
          message: 'Registration successful',
          token: token,
        );
      } else {
        return RegisterBaseResponse(
          status: false,
          message: 'Unexpected response status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Registration Failed';
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['error'] ?? e.message;
      } else {
        errorMessage = e.message ?? '';
      }
      return RegisterBaseResponse(status: false, message: errorMessage);
    } catch (e) {
      return RegisterBaseResponse(
        status: false,
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<void> signOut() async {
    // await auth.signOut();
  }

  @override
  Future<BaseResponse> registerSeller(
    SellerAccountModel sellerAccountModel,
  ) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.post(
        'seller-registration',
        data: {
          'name': sellerAccountModel.name,
          'email': sellerAccountModel.email,
          'phone_number': sellerAccountModel.phoneNum,
          'password': sellerAccountModel.password,
          'country': sellerAccountModel.country,
        },
      );
      if (response.statusCode == 200) {
        return BaseResponse(
          status: true,
          message: 'Seller registratedsuccessfully',
        );
      } else {
        return BaseResponse(
          status: false,
          message: 'Unexpected response status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Registration Failed';
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['error'] ?? e.message;
      } else {
        errorMessage = e.message ?? '';
      }
      return BaseResponse(status: false, message: errorMessage);
    } catch (e) {
      return BaseResponse(status: false, message: 'Unexpected error: $e');
    }
  }

  @override
  Future<SellerAccountModel> verifySellerOTP(
    SellerAccountModel sellerAccountModel,
    String otp,
  ) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.post(
        'verify-seller',
        data: {
          'name': sellerAccountModel.name,
          'email': sellerAccountModel.email,
          'phone_number': sellerAccountModel.phoneNum,
          'password': sellerAccountModel.password,
          'country': sellerAccountModel.country,
          'otp': otp,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final sellerData = response.data['seller'];

        await autoSellerLoginAfterVerification(
          sellerAccountModel.email ?? '',
          sellerAccountModel.password ?? '',
        );

        // Save the seller ID for future use
        if (sellerData['id'] != null) {
          await TokenStorage.saveSellerId(sellerData['id'].toString());
          print('💾 Saved sellerId: ${sellerData['id']}');
        }

        // Return updated SellerAccountModel with sellerId
        return SellerAccountModel(
          id: sellerData['id'],
          name: sellerData['name'],
          email: sellerData['email'],
          phoneNum: sellerData['phone_number'],
          password: sellerAccountModel.password, // Keep original plain password
          country: sellerData['country'],
        );
      } else {
        // Handle non-success status codes
        String errorMessage = 'Verification failed';
        if (response.data != null && response.data['message'] != null) {
          errorMessage = response.data['message'];
        } else if (response.data != null && response.data['error'] != null) {
          errorMessage = response.data['error'];
        }
        throw Exception(errorMessage);
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to verify OTP';

      if (e.response != null && e.response?.data != null) {
        // Extract error message from response
        if (e.response?.data['message'] != null) {
          errorMessage = e.response?.data['message'];
        } else if (e.response?.data['error'] != null) {
          errorMessage = e.response?.data['error'];
        } else if (e.response?.statusCode == 400) {
          errorMessage = 'Invalid OTP or user data';
        }
      } else {
        errorMessage = e.message ?? 'Network error occurred';
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<void> autoSellerLoginAfterVerification(
    String email,
    String password,
  ) async {
    print('🔐 Starting auto-login for seller: $email');
    try {
      final dio = await _dioFuture;
      print('📤 Making login request to login-seller endpoint...');

      final response = await dio.post(
        'login-seller',
        data: {'email': email, 'password': password},
      );

      print('📥 Login response received:');
      print('   Status code: ${response.statusCode}');
      print('   Response data: ${response.data}');

      if (response.statusCode == 200) {
        // Save token and role if returned from login
        if (response.data['token'] != null) {
          print('💾 Saving token: ${response.data['token']}');
          await TokenStorage.saveToken(response.data['token']);

          // Verify token was saved
          final savedToken = await TokenStorage.getToken();
          print('✅ Token verification - saved token: $savedToken');
        } else {
          print('⚠️ No token in login response');
        }

        // Try to save seller ID from auto-login response if available
        if (response.data['seller'] != null &&
            response.data['seller']['id'] != null) {
          await TokenStorage.saveSellerId(
            response.data['seller']['id'].toString(),
          );
          print(
            '💾 Saved sellerId from auto-login: ${response.data['seller']['id']}',
          );
        } else if (response.data['user'] != null &&
            response.data['user']['id'] != null) {
          await TokenStorage.saveSellerId(
            response.data['user']['id'].toString(),
          );
          print(
            '💾 Saved sellerId from auto-login (user field): ${response.data['user']['id']}',
          );
        }

        await TokenStorage.saveRole('seller');
        print('✅ Auto-login successful after seller verification');

        // Verify authentication status
        final isAuth = await TokenStorage.isAuthenticated();
        final isSeller = await TokenStorage.isSeller();
        print(
          '🔍 Final auth status: isAuthenticated=$isAuth, isSeller=$isSeller',
        );
      } else {
        print('⚠️ Auto-login failed with status: ${response.statusCode}');
        print('Response: ${response.data}');
        // Still save role even if login fails
        await TokenStorage.saveRole('seller');
      }
    } catch (e) {
      print('❌ Auto-login error: $e');
      // Still save role even if auto-login fails
      await TokenStorage.saveRole('seller');
    }
  }

  @override
  Future<StripeModel> createStripeConnectLink(String sellerId) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.post(
        'create-stripe-link',
        data: {'sellerId': sellerId},
      );

      if (response.statusCode == 200) {
        return StripeModel.fromJson(response.data);
      } else {
        return StripeModel(
          status: 'error',
          message: 'Failed to create Stripe connect link',
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to create Stripe connect link';
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['error'] ?? e.message ?? errorMessage;
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      return StripeModel(status: 'error', message: errorMessage);
    } catch (e) {
      return StripeModel(status: 'error', message: 'Unexpected error: $e');
    }
  }
}
