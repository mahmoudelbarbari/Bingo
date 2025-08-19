import 'dart:convert';
import 'dart:io';

import 'package:bingo/core/network/dio_provider.dart';
import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
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
  Future<List<ShopModel>> getBestSellers();
}

class ShopDatasourceImpl implements ShopDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.auth);
  final Future<Dio> _dioFuturePro = DioClient.createDio(ApiTarget.product);
  @override
  Future<BaseResponse> addShop(
    ShopModel shopModel,
    SellerAccountModel sellerAccountModel,
  ) async {
    try {
      // Check if user is authenticated and is a seller
      final isSeller = await TokenStorage.isSeller();

      if (!isSeller) {
        return BaseResponse(
          status: false,
          message: 'Only sellers can create shops.',
        );
      }

      final dio = await _dioFuture;

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

      final response = await dio.post('create-shop', data: requestData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Save the shopId from the response for future use
        final responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData['shopId'] != null) {
          await TokenStorage.saveShopId(responseData['shopId'].toString());
        } else if (responseData is Map<String, dynamic> &&
            responseData['shop'] != null &&
            responseData['shop']['id'] != null) {
          await TokenStorage.saveShopId(responseData['shop']['id'].toString());
        }

        return BaseResponse(status: true, message: 'Shop Added Successfully');
      } else {
        return BaseResponse(
          status: false,
          message: 'Failed to add shop: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
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
      return BaseResponse(status: false, message: 'Failed to add shop: $e');
    }
  }

  @override
  Future<void> addShopImage(File imageFile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final role = prefs.getString('auth_role');

      if (role != 'seller') {
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
      } else {
        throw ("Faild to upload ${response.statusMessage}");
      }
    } catch (e) {
      throw ('Unexpected error ${e.toString()}');
    }
  }

  @override
  Future<List<ShopModel>> getBestSellers() async {
    try {
      final dio = await _dioFuturePro;
      final response = await dio.get('best-sellers');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse all products first
        final List<ProductModel> allProducts =
            (response.data['products'] as List)
                .map((product) => ProductModel.fromJson(product))
                .toList();

        // Group products by shop ID
        final Map<String, List<ProductModel>> shopProductsMap = {};
        for (var product in allProducts) {
          if (product.shopId != null) {
            shopProductsMap.putIfAbsent(product.shopId!, () => []).add(product);
          }
        }

        // Create unique shops
        final List<ShopModel> shops = [];
        final Set<String> addedShopIds = {};

        for (var product in allProducts) {
          if (product.shop != null) {
            final shopId = product.shop!['id'];
            if (!addedShopIds.contains(shopId)) {
              addedShopIds.add(shopId);
              shops.add(
                ShopModel.fromJson({
                  ...product.shop!,
                  'products': shopProductsMap[shopId] ?? [],
                }),
              );
            }
          }
        }

        return shops;
      } else {
        throw Exception(
          'Failed to load best sellers: ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load best sellers: ${e.toString()}');
    }
  }
}
