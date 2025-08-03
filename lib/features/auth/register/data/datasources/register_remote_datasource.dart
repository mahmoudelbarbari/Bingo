import 'package:bingo/core/network/dio_provider.dart';
import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/auth/register/domain/entities/register_entities.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteRegisterDatasource {
  Future<RegisterBaseResponse> remoteRegisterUser(
    String name,
    String email,
    String password,
  );

  Future<UserCredential> firebaseRegister(String email, String password);
  Future<BaseResponse> addSellerData(SellerAccountModel sellerAccountModel);
  Future<void> signOut();
}

class RemoteRegisterDatasourceImpl implements RemoteRegisterDatasource {
  final Dio _dio = createDio(ApiTarget.auth);

  RemoteRegisterDatasourceImpl();

  @override
  Future<RegisterBaseResponse> remoteRegisterUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        'user-registration',
        data: {'name': name, 'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        return RegisterBaseResponse(
          status: true,
          message: 'Registration successful',
          token: token,
        );
      } else {
        return RegisterBaseResponse(
          status: false,
          message: 'Unexpected response status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Registration Failed';
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['error'] ?? e.message;
      } else {
        errorMessage = e.message ?? '';
      }
      return RegisterBaseResponse(status: false, message: errorMessage);
    } catch (e) {
      return RegisterBaseResponse(
        status: false,
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<BaseResponse> addSellerData(
    SellerAccountModel sellerAccountModel,
  ) async {
    try {
      // await firebaseFirestore
      //     .collection('sellers')
      //     .doc(sellerAccountModel.id)
      //     .set({
      //       'id': sellerAccountModel.id,
      //       "name": sellerAccountModel.name,
      //       "email": sellerAccountModel.email,
      //       "country": sellerAccountModel.country,
      //       "phoneNum": sellerAccountModel.phoneNum,
      //       'createdAt': FieldValue.serverTimestamp(),
      //       'isPhoneVerified': true,
      //     });
      return BaseResponse(status: true, message: 'Seller added Successfully');
    } catch (e) {
      return BaseResponse(
        status: false,
        message: 'Failed to save user data: $e',
      );
    }
  }

  @override
  Future<UserCredential> firebaseRegister(String email, String password) async {
    try {
      // Delete the temporary user
      if (_temporaryUserId != null) {
        // await auth.currentUser?.delete();
      }
      throw Exception();
      // return await auth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  @override
  Future<void> signOut() async {
    // await auth.signOut();
  }

  String? _temporaryUserId;
  String? get temporaryUserId => _temporaryUserId;
}
