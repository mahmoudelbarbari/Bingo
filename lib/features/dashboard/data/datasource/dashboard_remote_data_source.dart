import 'package:bingo/features/dashboard/data/models/discount_code_model.dart';
import 'package:bingo/features/dashboard/data/models/shop_stats_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper/token_storage.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/util/base_response.dart';
import '../models/revenue_data_model.dart';

abstract class DashboardRemoteDataSource {
  Future<List<RevenueDataModel>> getRevenueData();
  Future<ShopStatsModel> getShopStats();
  Future<BaseResponse> addDiscountCode(DiscountCodeModel discountCodeModel);
  Future<List<DiscountCodeModel>> getDiscountCodes();
  Future<BaseResponse> deleteDiscountCode(String discountCodeId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.seller);
  final Future<Dio> _dioFuturePro = DioClient.createDio(ApiTarget.product);

  DashboardRemoteDataSourceImpl();

  @override
  Future<List<RevenueDataModel>> getRevenueData() async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('dashboard/revenue');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return List<RevenueDataModel>.from(
          response.data.map((x) => RevenueDataModel.fromJson(x)),
        );
      } else {
        throw ('Something went wrong ${response.statusMessage}');
      }
    } catch (e) {
      throw ('Something went wrong $e');
    }
  }

  @override
  Future<ShopStatsModel> getShopStats() async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('dashboard/shop-stats');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ShopStatsModel.fromJson(response.data);
      } else {
        throw ('Something went worng ${response.statusMessage}');
      }
    } catch (e) {
      throw ('Something went worng ${e.toString()}');
    }
  }

  @override
  Future<BaseResponse> addDiscountCode(
    DiscountCodeModel discountCodeModel,
  ) async {
    try {
      final loggedUserData = await TokenStorage.getLoggedUserData();

      if (loggedUserData == null) {
        return BaseResponse(status: false, message: 'User not logged in');
      }
      final sellerId = loggedUserData['id'];
      final dio = await _dioFuturePro;
      final response = await dio.post(
        'create-discount-code',
        data: {
          'public_name': discountCodeModel.publicName,
          'discountType': discountCodeModel.discountType,
          'discountValue': discountCodeModel.discountValue,
          'discountCode': discountCodeModel.discountCode,
          'sellerId': sellerId,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return BaseResponse(
          status: true,
          message: 'Discount code added successfully',
        );
      } else {
        return BaseResponse(
          status: false,
          message: 'Something went wrong ${response.statusMessage}',
        );
      }
    } catch (e) {
      return BaseResponse(status: false, message: e.toString());
    }
  }

  @override
  Future<List<DiscountCodeModel>> getDiscountCodes() async {
    try {
      final dio = await _dioFuturePro;
      final response = await dio.get('get-discount-codes');
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Extract the discount_codes array from the response
        final List<dynamic> discountCodesJson = response.data['discount_codes'];
        return discountCodesJson
            .map((json) => DiscountCodeModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Something went wrong ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Something went wrong ${e.toString()}');
    }
  }

  @override
  Future<BaseResponse> deleteDiscountCode(String discountCodeId) async {
    try {
      final dio = await _dioFuturePro;
      final response = await dio.delete('delete-discount-code/$discountCodeId');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return BaseResponse(
          status: true,
          message: 'Discount code deleted successfully',
        );
      } else {
        return BaseResponse(
          status: false,
          message: 'Something went wrong ${response.statusMessage}',
        );
      }
    } catch (e) {
      return BaseResponse(status: false, message: e.toString());
    }
  }
}
