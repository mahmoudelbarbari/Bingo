import '../entities/product.dart';
import '../repo/seller_profile_repo.dart';

class GetSellerProducts {
  final SellerProfileRepository repository;

  GetSellerProducts(this.repository);

  Future<List<Product>> call(String sellerId) async {
    try {
      final products = await repository.getSellerProducts(sellerId);
      return products;
    } catch (e) {
      throw Exception('Failed to load seller products: $e');
    }
  }
}
