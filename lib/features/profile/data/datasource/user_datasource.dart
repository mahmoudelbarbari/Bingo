import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/profile/data/model/user_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/service/current_user_service.dart';
import '../../domain/entity/user.dart';

abstract class UserDatasource {
  Future<UserEntity> getCurrentUser();
  Future<BaseResponse> addUserAddress(AddressModel addressModel);
  Future<List<AddressModel>> getUserAddress(String userId);
}

class UserDatasourceImpl implements UserDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.auth);

  UserDatasourceImpl();

  @override
  Future<UserEntity> getCurrentUser() async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('logges-in-user');
      if (response.statusCode == 200) {
        return UserModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<BaseResponse> addUserAddress(AddressModel addressModel) async {
    try {
      final userId = await CurrentUserService.getCurrentUserId();
      if (userId == null) {
        return BaseResponse(status: false, message: 'User not authenticated');
      }
      final addressData = {
        'userId': userId,
        'label': addressModel.label,
        'name': addressModel.name,
        'street': addressModel.streetAddress,
        'city': addressModel.city,
        'state': addressModel.state,
        "zip": addressModel.zipCode,
        'country': addressModel.country,
        'isDefault': addressModel.isDefault,
      };
      final dio = await _dioFuture;
      final response = await dio.post('add-address', data: addressData);
      if (response.statusCode == 200) {
        return BaseResponse(
          status: true,
          message: 'Address added successfully',
        );
      } else {
        return BaseResponse(
          status: false,
          message: 'Faild to add the address ${response.statusMessage}',
        );
      }
    } catch (e) {
      return BaseResponse(status: false, message: 'Something went wrong $e');
    }
  }

  @override
  Future<List<AddressModel>> getUserAddress(String userId) async {
    try {
      final isAuthenticated = await CurrentUserService.getCurrentUserId();
      if (isAuthenticated == null) {
        throw ('User not authenticated');
      }
      final dio = await _dioFuture;
      final response = await dio.get('shipping-addresses/$userId');
      if (response.statusCode == 200) {
        final data = response.data;

        final List<dynamic> productData = data is List
            ? data
            : (data is Map && data['addresses'] is List)
            ? data['addresses']
            : throw Exception('Unexpected response format');

        return productData
            .cast<Map<String, dynamic>>()
            .map((item) => AddressModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to load address`s: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching address`s: $e');
    }
  }
}
