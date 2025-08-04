import 'package:bingo/features/auth/login/domain/entities/login_entities.dart';

abstract class LoginRepository {
  Future<LoginBaseResponse> remoteLogin(String email, String password);
  Future<void> resetPassword(String email, String newPassword);
  Future<void> sendOTP(String email);
  Future<bool> verifyOtp(String name, String email, String password, int otp);
}
