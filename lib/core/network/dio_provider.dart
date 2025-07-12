import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio createDio() {
  final baseUrl = dotenv.env['BASE_URL'];
  if (baseUrl == null || baseUrl.isEmpty) {
    throw Exception('BASE_URL not set in .env');
  }

  return Dio(BaseOptions(baseUrl: baseUrl));
}
