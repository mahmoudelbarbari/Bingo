import 'dart:io';

import 'package:bingo/features/shops/domain/repo/shops_repo.dart';

class AddShopImage {
  final ShopsRepo _shopsRepo;

  AddShopImage(this._shopsRepo);

  Future<void> call(File imageFile) async =>
      await _shopsRepo.addShopImage(imageFile);
}
