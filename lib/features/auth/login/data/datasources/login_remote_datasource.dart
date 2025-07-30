import '../../../../../core/network/dio_provider.dart';
import '../../domain/entities/login_entities.dart';
import 'package:dio/dio.dart';

abstract class RemoteLoginDatasource {
  Future<LoginBaseResponse> remoteLoginUser(String email, String password);
  Future<void> resetPassword(String email, String newPassword);
  Future<void> sendOTP(String email);
  Future<void> verifyOtp(String email, String otp);
}

class RemoteLoginDatasourceImpl implements RemoteLoginDatasource {
  final Dio _dio = createDio(ApiTarget.auth);

  RemoteLoginDatasourceImpl();

  @override
  Future<LoginBaseResponse> remoteLoginUser(
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        'login-user',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final token = response.data['token'];
        return LoginBaseResponse(
          status: true,
          message: 'Login successful',
          token: token,
        );
      } else {
        return LoginBaseResponse(
          status: false,
          message: 'Unexpected response status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Login Failed';
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['error'] ?? e.message;
      } else {
        errorMessage = e.message ?? '';
      }
      return LoginBaseResponse(status: false, message: errorMessage);
    } catch (e) {
      return LoginBaseResponse(status: false, message: 'Unexpected error: $e');
    }
  }

  @override
  Future<void> resetPassword(String email, String newPassword) async {
    await _dio.post(
      'reset-password-user',
      data: {'email': email, 'new_password': newPassword},
    );
  }

  @override
  Future<void> sendOTP(String email) async {
    await _dio.post('send-otp', data: {'email': email});
  }

  @override
  Future<void> verifyOtp(String email, String otp) async {
    await _dio.post('verify-user', data: {'email': email, 'otp': otp});
  }
}
