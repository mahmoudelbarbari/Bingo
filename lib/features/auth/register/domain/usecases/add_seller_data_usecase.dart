import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';

import '../repositories/register_repository.dart';

class AddSellerDataUsecase {
  final RegisterRepository _registerRepository;

  AddSellerDataUsecase(this._registerRepository);

  Future<BaseResponse> call(SellerAccountModel sellerAccountModel) async =>
      await _registerRepository.addSellerData(sellerAccountModel);
}
