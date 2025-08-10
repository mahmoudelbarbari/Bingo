import '../entities/seller_profile.dart';
import '../entities/product.dart';
import '../entities/event.dart';
import '../entities/review.dart';

abstract class SellerProfileRepository {
  Future<SellerProfile> getSellerProfile(String sellerId);
  Future<List<Product>> getSellerProducts(String sellerId);
  Future<List<Event>> getSellerEvents(String sellerId);
  Future<List<Review>> getSellerReviews(String sellerId);
}
