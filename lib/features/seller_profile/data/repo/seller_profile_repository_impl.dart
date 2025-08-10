import '../../domain/entities/seller_profile.dart';
import '../../domain/entities/product.dart';
import '../../domain/repo/seller_profile_repo.dart';
import '../datasources/seller_profile_remote_data_source_impl.dart';
import '../models/seller_profile_model.dart';
import '../models/product_model.dart';
import '../models/event_model.dart';
import '../models/review_model.dart';

class SellerProfileRepositoryImpl implements SellerProfileRepository {
  final SellerProfileRemoteDataSource remoteDataSource;

  SellerProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<SellerProfile> getSellerProfile(String sellerId) async {
    try {
      final SellerProfileModel model = await remoteDataSource.getSellerProfile(
        sellerId,
      );
      return model;
    } catch (e) {
      throw Exception('Failed to fetch seller profile');
    }
  }

  @override
  Future<List<Product>> getSellerProducts(String sellerId) async {
    try {
      final List<ProductProfileModel> models = await remoteDataSource
          .getSellerProducts(sellerId);
      return models;
    } catch (e) {
      throw Exception('Failed to fetch seller products');
    }
  }

  @override
  Future<List<EventModel>> getSellerEvents(String sellerId) async {
    try {
      return await remoteDataSource.getSellerEvents(sellerId);
    } catch (e) {
      throw Exception('Failed to fetch seller events');
    }
  }

  @override
  Future<List<ReviewModel>> getSellerReviews(String sellerId) async {
    try {
      return await remoteDataSource.getSellerReviews(sellerId);
    } catch (e) {
      throw Exception('Failed to fetch seller reviews');
    }
  }
}
