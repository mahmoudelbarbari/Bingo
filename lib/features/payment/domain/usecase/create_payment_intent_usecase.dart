import 'package:bingo/features/payment/domain/repo/payment_repo.dart';
import '../../data/models/payment_session_model.dart';

class CreatePaymentIntentUsecase {
  final PaymentRepo _paymentRepo;

  CreatePaymentIntentUsecase(this._paymentRepo);

  Future<PaymentIntentModel> call(
    double amount,
    String stripeAccountId,
    String sessionId,
  ) async => await _paymentRepo.createPaymentIntent(
    amount: amount,
    stripeAccountId: stripeAccountId,
    sessionId: sessionId,
  );
}
