import 'package:bingo/core/helper/token_storage.dart';
import 'package:bingo/core/network/dio_provider.dart';
import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:bingo/features/product/domain/entity/product.dart';
import 'package:dio/dio.dart';

abstract class ProductDatasource {
  Future<List<ProductEntity>> getAllProduct();
  Future<List<ProductEntity>> getProductsByShopId(String shopId);
  Future<BaseResponse> createProduct(ProductModel product);
}

class ProductDatasourceImpl implements ProductDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.product);

  @override
  Future<List<ProductEntity>> getAllProduct() async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('get-all-products');

      if (response.statusCode == 200) {
        final data = response.data;
        
        if (data is! Map<String, dynamic>) {
          throw Exception('Expected Map<String, dynamic> but got ${data.runtimeType}');
        }
        
        final productsData = data['products'];
        if (productsData is! List) {
          throw Exception('Expected products to be a List but got ${productsData.runtimeType}');
        }

        final List<ProductEntity> products = [];
        for (int i = 0; i < productsData.length; i++) {
          try {
            final item = productsData[i];
            if (item is! Map<String, dynamic>) {
              print('Item at index $i is not Map<String, dynamic>: ${item.runtimeType}');
              continue;
            }
            final product = ProductModel.fromJson(item);
            products.add(product);
          } catch (e) {
            print('Error parsing product at index $i: $e');
            // Continue with other products instead of failing completely
          }
        }
        
        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Future<List<ProductEntity>> getProductsByShopId(String shopId) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('get-products-by-shop/$shopId');

      if (response.statusCode == 200) {
        final data = response.data;
        
        if (data is! Map<String, dynamic>) {
          throw Exception('Expected Map<String, dynamic> but got ${data.runtimeType}');
        }
        
        final productsData = data['products'];
        if (productsData is! List) {
          throw Exception('Expected products to be a List but got ${productsData.runtimeType}');
        }

        final List<ProductEntity> products = [];
        for (int i = 0; i < productsData.length; i++) {
          try {
            final item = productsData[i];
            if (item is! Map<String, dynamic>) {
              print('Item at index $i is not Map<String, dynamic>: ${item.runtimeType}');
              continue;
            }
            final product = ProductModel.fromJson(item);
            products.add(product);
          } catch (e) {
            print('Error parsing product at index $i: $e');
            // Continue with other products instead of failing completely
          }
        }
        
        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products by shop ID: $e');
    }
  }

  @override
  Future<BaseResponse> createProduct(ProductModel product) async {
    try {
      final dio = await _dioFuture;

      // Get logged user data
      final loggedUserData = await TokenStorage.getLoggedUserData();

      if (loggedUserData == null) {
        return BaseResponse(status: false, message: 'User not logged in');
      }

      // Extract shop ID from the nested shop object
      String? shopId;
      if (loggedUserData['shop'] != null && loggedUserData['shop'] is Map) {
        final shopData = loggedUserData['shop'] as Map<String, dynamic>;
        shopId = shopData['id']?.toString();
      }

      if (shopId == null || shopId.isEmpty) {
        return BaseResponse(
          status: false,
          message: 'Shop not found. Please create a shop first.',
        );
      }

      // Create a new product model with the shopId
      final productWithShopId = ProductModel(
        id: product.id,
        title: product.title,
        shortDescription: product.shortDescription,
        brand: product.brand,
        cashOnDelivery: product.cashOnDelivery,
        category: product.category,
        colors: product.colors,
        customProperties: product.customProperties,
        detailedDesc: product.detailedDesc,
        price: product.price,
        salePrice: product.salePrice,
        sizes: product.sizes,
        slug: product.slug,
        stock: product.stock,
        subCategory: product.subCategory,
        tags: product.tags,
        videoURL: product.videoURL,
        warranty: product.warranty,
        image: product.image,
        shopId: shopId,
      );

      final response = await dio.post(
        'create-product',
        data: productWithShopId.toJson(),
      );

      if (response.statusCode == 200) {
        return BaseResponse(
          status: true,
          message: 'Product created successfully',
        );
      } else {
        return BaseResponse(
          status: false,
          message: 'Failed: ${response.statusMessage}',
        );
      }
    } catch (e) {
      return BaseResponse(status: false, message: 'Error: $e');
    }
  }
}
