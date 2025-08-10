import '../entities/seller_profile.dart';
import '../repo/seller_profile_repo.dart';

class GetSellerProfile {
  final SellerProfileRepository repository;

  GetSellerProfile(this.repository);

  Future<SellerProfile?> call(String sellerId) async {
    try {
      final profile = await repository.getSellerProfile(sellerId);
      return profile;
    } catch (e) {
      print('Error fetching seller profile: $e');
      return null;
    }
  }
}
