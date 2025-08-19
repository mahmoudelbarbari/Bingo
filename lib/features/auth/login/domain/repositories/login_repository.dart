import 'package:bingo/features/auth/login/domain/entities/login_entities.dart';

import '../../../../../core/util/base_response.dart';

abstract class LoginRepository {
  Future<LoginBaseResponse> remoteLogin(
    String email,
    String password,
    bool isSeller,
  );
  Future<void> resetPassword(String email, String newPassword);
  Future<void> sendOTP(String email);
  Future<bool> verifyOtp(String name, String email, String password, int otp);
  Future<BaseResponse> logout(bool isSeller);
}
