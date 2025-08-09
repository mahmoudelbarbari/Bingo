// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// Dio createDio() {
//   final baseUrl = dotenv.env['BASE_URL'];
//   if (baseUrl == null || baseUrl.isEmpty) {
//     throw Exception('BASE_URL not set in .env');
//   }

//   return Dio(BaseOptions(baseUrl: baseUrl));
// }

// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:path_provider/path_provider.dart';

// enum ApiTarget { auth, product, seller, order, admin, chatting }

// Dio createDio(ApiTarget target) {
//   late final String? baseUrl;

//   switch (target) {
//     case ApiTarget.auth:
//       baseUrl = dotenv.env['AUTH_BASE_URL'];
//       print('🔗 AUTH_BASE_URL: $baseUrl'); // Add this
//       break;
//     case ApiTarget.product:
//       baseUrl = dotenv.env['PRODUCT_BASE_URL'];
//       break;
//     case ApiTarget.seller:
//       baseUrl = dotenv.env['SELLER_BASE_URL'];
//       break;
//     case ApiTarget.order:
//       baseUrl = dotenv.env['ORDER_BASE_URL'];
//       break;
//     case ApiTarget.admin:
//       baseUrl = dotenv.env['ADMIN_BASE_URL'];
//       break;
//     case ApiTarget.chatting:
//       baseUrl = dotenv.env['CHATTING_BASE_URL'];
//       break;
//   }

//   if (baseUrl == null || baseUrl.isEmpty) {
//     throw Exception('Base URL for $target not set in .env');
//   }

//   final dio = Dio(
//     BaseOptions(
//       baseUrl: baseUrl,
//       validateStatus: (status) {
//         return status != null && status < 500;
//       },
//     ),
//   );

//   // 🍪 Add persistent CookieJar only to specific APIs
//   if (target == ApiTarget.auth ||
//       target == ApiTarget.product ||
//       target == ApiTarget.seller) {
//     final appDocDir = getApplicationDocumentsDirectory();
//     final cookiePath = "${appDocDir.path}/.cookies";
//     final cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));
//     dio.interceptors.add(CookieManager(cookieJar));
//   }

//   // Add detailed logging
//   dio.interceptors.add(
//     LogInterceptor(
//       requestHeader: true,
//       requestBody: true,
//       responseHeader: true,
//       responseBody: true,
//       error: true,
//       logPrint: (obj) => print('🌐 DIO: $obj'),
//     ),
//   );

//   return dio;
// }

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

import '../helper/token_storage.dart';

enum ApiTarget { auth, product, seller, order, admin, chatting }

class DioClient {
  static PersistCookieJar? _cookieJar;

  static Future<Dio> createDio(ApiTarget target) async {
    late final String? baseUrl;

    switch (target) {
      case ApiTarget.auth:
        baseUrl = dotenv.env['AUTH_BASE_URL'];
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
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    // 🧠 Global persistent cookie jar (initialized once)
    if (_cookieJar == null) {
      final dir = await getApplicationDocumentsDirectory();
      _cookieJar = PersistCookieJar(
        storage: FileStorage('${dir.path}/.cookies'),
      );
    }

    dio.interceptors.add(CookieManager(_cookieJar!));

    // Add authentication interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add authorization header if token exists
          final token = await TokenStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          // Handle 401 unauthorized errors
          if (error.response?.statusCode == 401) {
            // Clear invalid token
            await TokenStorage.clearAll();
            print('🔒 Token expired or invalid, cleared from storage');
          }
          handler.next(error);
        },
      ),
    );

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
}
