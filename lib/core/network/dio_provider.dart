// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// Dio createDio() {
//   final baseUrl = dotenv.env['BASE_URL'];
//   if (baseUrl == null || baseUrl.isEmpty) {
//     throw Exception('BASE_URL not set in .env');
//   }

//   return Dio(BaseOptions(baseUrl: baseUrl));
// }

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum ApiTarget { auth, user }

Dio createDio(ApiTarget target) {
  late final String? baseUrl;

  switch (target) {
    case ApiTarget.auth:
      baseUrl = dotenv.env['AUTH_BASE_URL'];
      print('AUTH_BASE_URL: $baseUrl'); // Add this line
      break;
    case ApiTarget.user:
      baseUrl = dotenv.env['BASE_URL'];
      break;
  }

  if (baseUrl == null || baseUrl.isEmpty) {
    throw Exception('Base URL for $target not set in .env');
  }
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  // Add interceptors for debugging
  dio.interceptors.add(
    LogInterceptor(requestBody: true, responseBody: true, error: true),
  );

  return Dio(BaseOptions(baseUrl: baseUrl));
}
