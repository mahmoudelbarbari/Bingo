import 'package:bingo/features/payment/domain/repo/payment_repo.dart';
import '../../data/models/payment_session_model.dart';

class CheckoutUsecase {
  final PaymentRepo _paymentRepo;

  CheckoutUsecase(this._paymentRepo);

  Future<PaymentSessionModel> call(
    List<Map<String, dynamic>> cartItems,
    String? addressId,
    String? coupon,
  ) async => await _paymentRepo.createPaymentSession(
    cartItems: cartItems,
    addressId: addressId,
    coupon: coupon,
  );
}
