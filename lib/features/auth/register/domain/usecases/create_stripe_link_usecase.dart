import 'package:bingo/features/auth/register/data/model/stripe_model.dart';

import '../repositories/register_repository.dart';

class CreateStripeLinkUsecase {
  final RegisterRepository _registerRepository;

  CreateStripeLinkUsecase(this._registerRepository);

  Future<StripeModel> call(String sellerId) async =>
      await _registerRepository.createStripeConnectLink(sellerId);
}
