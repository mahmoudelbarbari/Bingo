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

enum ApiTarget { auth, product, seller, order, admin, chatting }

Dio createDio(ApiTarget target) {
  late final String? baseUrl;

  switch (target) {
    case ApiTarget.auth:
      baseUrl = dotenv.env['AUTH_BASE_URL'];
      print('🔗 AUTH_BASE_URL: $baseUrl'); // Add this
      break;
    case ApiTarget.product:
      baseUrl = dotenv.env['PRODUCT_BASE_URL'];
      break;
    case ApiTarget.seller:
      baseUrl = dotenv.env['SELLER_BASE_URL'];
      break;
    case ApiTarget.order:
      baseUrl = dotenv.env['ORDER_BASE_URL'];
      break;
    case ApiTarget.admin:
      baseUrl = dotenv.env['ADMIN_BASE_URL'];
      break;
    case ApiTarget.chatting:
      baseUrl = dotenv.env['CHATTING_BASE_URL'];
      break;
  }

  if (baseUrl == null || baseUrl.isEmpty) {
    throw Exception('Base URL for $target not set in .env');
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );

  // Add detailed logging
  dio.interceptors.add(
    LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (obj) => print('🌐 DIO: $obj'),
    ),
  );

  return dio;
}
