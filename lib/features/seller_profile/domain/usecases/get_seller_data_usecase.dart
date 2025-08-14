import 'package:bingo/features/seller_profile/domain/repo/seller_profile_repo.dart';
import 'package:bingo/features/shops/domain/entity/shop_entity.dart';

class GetSellerDataUsecase {
  final SellerProfileRepository _sellerProfileRepository;

  GetSellerDataUsecase(this._sellerProfileRepository);

  Future<ShopEntity> call() async =>
      await _sellerProfileRepository.getSellerData();
}
