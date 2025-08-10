import '../entities/review.dart';
import '../repo/seller_profile_repo.dart';

class GetSellerReviewsUseCase {
  final SellerProfileRepository repository;

  GetSellerReviewsUseCase(this.repository);

  Future<List<Review>> call(String sellerId) async {
    return await repository.getSellerReviews(sellerId);
  }
}
