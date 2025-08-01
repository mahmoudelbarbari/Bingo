import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/login_entities.dart';
import 'package:dio/dio.dart';

class FirebaseDatasourceProvider {
  static final _firebaseDatasourceProvider =
      FirebaseDatasourceProvider._internal();

  factory FirebaseDatasourceProvider() {
    return _firebaseDatasourceProvider;
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseDatasourceProvider._internal();
}

abstract class RemoteLoginDatasource extends FirebaseDatasourceProvider {
  RemoteLoginDatasource() : super._internal();

  Future<LoginBaseResponse> remoteLoginUser(String email, String password);
  Future<void> resetPassword(String email, String newPassword);
  Future<void> sendOTP(String email);
  Future<bool> verifyOtp(String email);
}

class RemoteLoginDatasourceImpl extends RemoteLoginDatasource {
  final Dio _dio;

  RemoteLoginDatasourceImpl(this._dio) : super();

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
    // await _dio.post('send-otp', data: {'email': email});
    try {
      // Create a temporary user to send verification email
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: 'temporary_password_${DateTime.now().millisecondsSinceEpoch}',
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Store the temporary user ID for later use
      _temporaryUserId = userCredential.user!.uid;
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  @override
  Future<bool> verifyOtp(String email) async {
    // await _dio.post('verify-user', data: {'email': email, 'otp': otp});
    try {
      // Reload user to get latest verification status
      await auth.currentUser?.reload();

      final user = auth.currentUser;
      if (user != null && user.emailVerified) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }

  // Get current user
  User? get currentUser => auth.currentUser;
  // Store verification ID
  String? _temporaryUserId;
  String? get temporaryUserId => _temporaryUserId;
}
