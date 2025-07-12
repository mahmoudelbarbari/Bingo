import 'package:bingo/features/auth/register/domain/entities/register_entities.dart';
import 'package:dio/dio.dart';

abstract class RemoteRegisterDatasource {
  Future<RegisterBaseResponse> remoteRegisterUser(String name, String email, String password);
}

class RemoteRegisterDatasourceImpl implements RemoteRegisterDatasource {
  final Dio _dio;

  RemoteRegisterDatasourceImpl(this._dio);

  @override
  Future<RegisterBaseResponse> remoteRegisterUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        'register-user',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
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
}
