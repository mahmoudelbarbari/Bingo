import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/auth/register/domain/entities/register_entities.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterRepository {
  Future<RegisterBaseResponse> remoteRegister(
    String name,
    String email,
    String password,
  );
  Future<UserCredential> firebaseRegister(String email, String password);

  Future<BaseResponse> addSellerData(SellerAccountModel sellerAccountModel);
  Future<void> signOut();
}
