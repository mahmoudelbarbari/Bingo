import 'dart:convert';
import 'dart:io';

import 'package:bingo/core/network/dio_provider.dart';
import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/shops/data/models/shop_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/helper/token_storage.dart';

abstract class ShopDatasource {
  Future<BaseResponse> addShop(
    ShopModel shopModel,
    SellerAccountModel sellerAccountModel,
  );

  Future<void> addShopImage(File imageFile);
}

class ShopDatasourceImpl implements ShopDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.auth);

  @override
  Future<BaseResponse> addShop(
    ShopModel shopModel,
    SellerAccountModel sellerAccountModel,
  ) async {
    print('🏪 addShop called with:');
    print('   Shop name: ${shopModel.name}');
    print('   Shop address: ${shopModel.address}');
    print('   Seller ID: ${sellerAccountModel.id}');

    try {
      // Check if user is authenticated and is a seller
      final isSeller = await TokenStorage.isSeller();

      print('🔐 Authentication check:');
      print('   isSeller: $isSeller');

      if (!isSeller) {
        print('❌ User is not a seller');
        return BaseResponse(
          status: false,
          message: 'Only sellers can create shops.',
        );
      }

      final dio = await _dioFuture;
      print('🌐 Making POST request to create-shop...');

      final requestData = {
        'name': shopModel.name,
        'address': shopModel.address,
        'opening_hours': shopModel.openingHours,
        'bio': shopModel.bio,
        'category': shopModel.category,
        'email': sellerAccountModel.email,
        'phone_number': sellerAccountModel.phoneNum,
        'country': sellerAccountModel.country,
        'sellerId': sellerAccountModel.id,
      };

      print('📤 Request data: $requestData');

      final response = await dio.post('create-shop', data: requestData);

      print('📥 Response received:');
      print('   Status code: ${response.statusCode}');
      print('   Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Shop created successfully');

        // Save the shopId from the response for future use
        final responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData['shopId'] != null) {
          await TokenStorage.saveShopId(responseData['shopId'].toString());
          print('💾 Saved shopId: ${responseData['shopId']}');
        } else if (responseData is Map<String, dynamic> &&
            responseData['shop'] != null &&
            responseData['shop']['id'] != null) {
          await TokenStorage.saveShopId(responseData['shop']['id'].toString());
          print('💾 Saved shopId: ${responseData['shop']['id']}');
        }

        return BaseResponse(status: true, message: 'Shop Added Successfully');
      } else {
        print('❌ Shop creation failed');
        return BaseResponse(
          status: false,
          message: 'Failed to add shop: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      print('❌ DioException: ${e.message}');
      if (e.response?.statusCode == 401) {
        return BaseResponse(
          status: false,
          message: 'Authentication failed. Please login again.',
        );
      }
      return BaseResponse(
        status: false,
        message: 'Failed to add shop: ${e.message}',
      );
    } catch (e) {
      print('❌ General exception: $e');
      return BaseResponse(status: false, message: 'Failed to add shop: $e');
    }
  }

  @override
  Future<void> addShopImage(File imageFile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final role = prefs.getString('auth_role');

      if (role != 'seller') {
        print("Only sellers are allowed to upload images.");
        return null;
      }

      // 2. Optional: Get auth token if required by API
      final token = prefs.getString('auth_token'); // change key if needed
      final dio = await _dioFuture;

      // Read image as bytes
      final bytes = await imageFile.readAsBytes();
      // Convert to base64
      final base64Image = base64Encode(bytes);
      // Send as JSON instead of FormData
      final requestData = {'fileName': base64Image};
      final response = await dio.post(
        'upload-image',
        data: requestData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Image upload success');
      } else {
        throw ("Faild to upload ${response.statusMessage}");
      }
    } catch (e) {
      throw ('Unexpected error ${e.toString()}');
    }
  }
}
