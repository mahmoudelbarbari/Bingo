import 'package:bingo/core/util/base_response.dart';

import '../reporisatory/cart_reporisatory.dart';

class DeleteItemByIdUsecase {
  final CartReporisatoryInterface cartReporisatoryInterface;

  DeleteItemByIdUsecase(this.cartReporisatoryInterface);

  Future<BaseResponse> call(String id) =>
      (cartReporisatoryInterface.deleteItemByID(id));
}
