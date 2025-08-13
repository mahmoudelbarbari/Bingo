import 'package:bingo/features/payment/domain/repo/payment_repo.dart';
import '../../data/models/payment_session_model.dart';

class VerifyPaymentUsecase {
  final PaymentRepo _paymentRepo;

  VerifyPaymentUsecase(this._paymentRepo);

  Future<PaymentVerificationModel> call(String sessionId) async =>
      await _paymentRepo.verifyPaymentSession(sessionId: sessionId);
}
