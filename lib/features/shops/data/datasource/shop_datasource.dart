import 'dart:convert';
import 'dart:io';

import 'package:bingo/core/network/dio_provider.dart';
import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/shops/data/models/shop_model.dart';
import 'package:dio/dio.dart';

abstract class ShopDatasource {
  Future<BaseResponse> addShop(
    ShopModel shopModel,
    SellerAccountModel sellerAccountModel,
  );

  Future<void> addShopImage(File imageFile);
}

class ShopDatasourceImpl implements ShopDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.seller);

  @override
  Future<BaseResponse> addShop(
    ShopModel shopModel,
    SellerAccountModel sellerAccountModel,
  ) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.post(
        'create-shop',
        data: {
          'name': shopModel.name,
          'address': shopModel.address,
          'opening_hours': shopModel.openingHours,
          'bio': shopModel.bio,
          'category': shopModel.category,
          'email': sellerAccountModel.email,
          'phone_number': sellerAccountModel.phoneNum,
          'country': sellerAccountModel.country,
          'sellerId': sellerAccountModel.id,
        },
      );
      if (response.statusCode == 200) {
        return BaseResponse(status: true, message: 'Shop Added Successfully');
      } else {
        return BaseResponse(
          status: false,
          message: 'Failed to add shop: ${response.statusMessage}',
        );
      }
    } catch (e) {
      return throw (message: 'Failed to add shop: $e');
    }
  }

  @override
  Future<void> addShopImage(File imageFile) async {
    try {
      final dio = await _dioFuture;
      // Read image as bytes
      final bytes = await imageFile.readAsBytes();
      // Convert to base64
      final base64Image = base64Encode(bytes);
      final response = await dio.post(
        'upload-image',
        data: {'image': base64Image},
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
