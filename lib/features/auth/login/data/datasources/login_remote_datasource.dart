import 'package:bingo/core/network/dio_provider.dart';
import 'package:bingo/core/util/base_response.dart';

import '../../../../../core/helper/token_storage.dart';
import '../../domain/entities/login_entities.dart';
import 'package:dio/dio.dart';

abstract class RemoteLoginDatasource {
  Future<LoginBaseResponse> remoteLoginUser(
    String email,
    String password,
    bool isSeller,
  );
  Future<void> resetPassword(String email, String newPassword);
  Future<void> sendOTP(String email);
  Future<bool> verifyOtp(String name, String email, String password, int otp);
  Future<BaseResponse> logout(bool isSeller);
}

class RemoteLoginDatasourceImpl implements RemoteLoginDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.auth);

  @override
  Future<void> resetPassword(String email, String newPassword) async {
    final dio = await _dioFuture;

    await dio.post(
      'reset-password-user',
      data: {'email': email, 'new_password': newPassword},
    );
  }

  @override
  Future<void> sendOTP(String email) async {
    try {
      final dio = await _dioFuture;

      await dio.post('send-otp', data: {'email': email});
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  // ... existing code ...

  // ... existing code ...

  @override
  Future<bool> verifyOtp(
    String name,
    String email,
    String password,
    int otp,
  ) async {
    try {
      final dio = await _dioFuture;

      final requestData = {
        'name': name,
        'email': email,
        'password': password,
        'otp': otp.toString(), // Convert to string
      };

      final response = await dio.post('verify-user', data: requestData);

      // Check if the request was successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
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
  Future<LoginBaseResponse> remoteLoginUser(
    String email,
    String password,
    bool isSeller,
  ) async {
    try {
      final dio = await _dioFuture;
      final endpoint = isSeller ? 'login-seller' : 'login-user';

      final response = await dio.post(
        endpoint,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        // 🚨 Extract token from `set-cookie` header
        final cookies = response.headers['set-cookie'];
        if (cookies != null) {
          String? accessToken;
          for (final cookie in cookies) {
            if (cookie.startsWith('access_Token=')) {
              accessToken = cookie.split(';')[0].split('=')[1];
              break;
            }
          }
          if (accessToken != null) {
            await TokenStorage.saveToken(accessToken); // Save token
            print('🔑 Token saved: $accessToken');
          } else {
            print('❌ No access token found in cookies');
          }
        } else {
          print('❌ No cookies found in response');
        }

        await TokenStorage.saveRole(isSeller ? 'seller' : 'user');

        // 👇 Handle data saving for BOTH user types 👇
        if (isSeller) {
          final sellerData = await dio.get('logged-in-seller');

          // Seller login handling
          dynamic userData = response.data['seller'] ?? response.data['user'];
          dynamic s = sellerData.data['seller'];
          if (userData != null && userData['id'] != null) {
            await TokenStorage.saveSellerId(userData['id'].toString());
            await TokenStorage.saveCurrentUser(userData);
            await TokenStorage.saveLoggedUserData(s);
          }
        } else {
          final userData = await dio.get('logged-in-user');
          // Regular user handling
          if (response.data['user'] != null &&
              response.data['user']['id'] != null) {
            await TokenStorage.saveCurrentUser(response.data['user']);
            await TokenStorage.saveLoggedUserData(userData.data['user']);
          }
        }

        return LoginBaseResponse(status: true, message: 'Login successful');
      } else {
        return LoginBaseResponse(
          status: false,
          message: 'Unexpected status: ${response.statusCode}',
        );
      }
    } catch (e) {
      return LoginBaseResponse(status: false, message: 'Login error: $e');
    }
  }

  @override
  Future<BaseResponse> logout(bool isSeller) async {
    try {
      final endpoint = isSeller ? 'logout-seller' : 'logout-user';
      final dio = await _dioFuture;

      final response = await dio.get(endpoint);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await TokenStorage.clearToken();
        return BaseResponse(status: true, message: 'Logout successful');
      } else {
        return BaseResponse(
          status: false,
          message: 'Unexpected status: ${response.statusCode}',
        );
      }
    } catch (e) {
      return BaseResponse(
        status: false,
        message: 'Something went wrong ! ${e.toString()}',
      );
    }
  }
}
