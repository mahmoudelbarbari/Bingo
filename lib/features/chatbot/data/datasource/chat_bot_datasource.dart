import 'package:dio/dio.dart';

abstract class ChatBotDatasource {
  Future<String> sendMessage(String message);
}

class ChatBotDatasourceImpl implements ChatBotDatasource {
  final Dio _dio;

  ChatBotDatasourceImpl(this._dio);

  @override
  Future<String> sendMessage(String message) async {
    try {
      final response = await _dio.post('chat-bot', data: {'message': message});
      if (response.statusCode == 200) {
        return response.data['response'];
      } else {
        return 'Unexpected response status: ${response.statusCode}';
      }
    } on DioException catch (e) {
      String errorMessage = 'Login Failed';
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['error'] ?? e.message;
      } else {
        errorMessage = e.message ?? '';
      }
      return errorMessage;
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }
}
