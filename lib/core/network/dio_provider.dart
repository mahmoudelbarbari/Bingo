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
      break;
    case ApiTarget.user:
      baseUrl = dotenv.env['BASE_URL'];
      break;
  }

  if (baseUrl == null || baseUrl.isEmpty) {
    throw Exception('Base URL for $target not set in .env');
  }

  return Dio(BaseOptions(baseUrl: baseUrl));
}
