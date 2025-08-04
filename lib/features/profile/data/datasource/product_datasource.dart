import 'package:bingo/features/profile/data/model/product_model.dart';
import 'package:bingo/features/profile/domain/entity/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatasourceProvider {
  static final _firebaseDatasourceProvider =
      FirebaseDatasourceProvider._internal();

  factory FirebaseDatasourceProvider() {
    return _firebaseDatasourceProvider;
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseDatasourceProvider._internal();
}

abstract class ProductDatasource extends FirebaseDatasourceProvider {
  ProductDatasource() : super._internal();

  Future<List<ProductEntity>> getAllProduct();
}

class ProductDatasourceImpl extends ProductDatasource {
  ProductDatasourceImpl() : super();

  @override
  Future<List<ProductEntity>> getAllProduct() async {
    try {
      // final response = await dio.get('/get-shop-products');

      // if (response.statusCode == 200) {
      //   final data = response.data;

      //   // Make sure the response is a list
      //   if (data is List) {
      //     // Parse each item in the list to a ProductModel
      //     return data
      //         .map((item) => ProductModel.fromMap(item as Map<String, dynamic>))
      //         .toList();
      //   } else if (data is Map && data['products'] is List) {
      //     // In case products are nested
      //     return (data['products'] as List)
      //         .map((item) => ProductModel.fromMap(item as Map<String, dynamic>))
      //         .toList();
      //   } else {
      //     throw Exception('Unexpected response format');
      //   }
      // } else {
      //   throw Exception('Failed to load products: ${response.statusCode}');
      // }
      final retrive = firebaseFirestore.collection('products');
      final querySnapshot = await retrive.get();
      querySnapshot.docs.map((e) => e.data()).toList();
      List<ProductModel> products = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in querySnapshot.docs) {
        products.add(ProductModel.fromSnapShot(doc));
      }
      return products;
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
