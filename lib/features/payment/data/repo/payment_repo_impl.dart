import 'package:bingo/features/payment/data/datasource/payment_datasource.dart';
import 'package:bingo/features/payment/data/models/payment_session_model.dart';
import 'package:bingo/features/payment/domain/repo/payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentDatasource _paymentDatasource;

  PaymentRepoImpl(this._paymentDatasource);

  @override
  Future<PaymentIntentModel> createPaymentIntent({
    required double amount,
    required String stripeAccountId,
    required String sessionId,
  }) async {
    return await _paymentDatasource.createPaymentIntent(
      amount: amount,
      stripeAccountId: stripeAccountId,
      sessionId: sessionId,
    );
  }

  @override
  Future<PaymentSessionModel> createPaymentSession({
    required List<Map<String, dynamic>> cartItems,
    String? addressId,
    String? coupon,
  }) async {
    return await _paymentDatasource.createPaymentSession(
      cartItems: cartItems,
      addressId: addressId,
      coupon: coupon,
    );
  }

  @override
  Future<PaymentVerificationModel> verifyPaymentSession({
    required String sessionId,
  }) async {
    return await _paymentDatasource.verifyPaymentSession(sessionId: sessionId);
  }

  @override
  Future<PaymentSessionModel> checkout({
    required List<Map<String, dynamic>> cartItems,
    String? addressId,
    String? coupon,
  }) async {
    return await _paymentDatasource.checkout(
      cartItems: cartItems,
      addressId: addressId,
      coupon: coupon,
    );
  }

  @override
  Future<String> createPaymentIntentLegacy({
    required double amount,
    required String stripeAccountId,
    required String sessionId,
  }) async {
    final paymentIntent = await _paymentDatasource.createPaymentIntent(
      amount: amount,
      stripeAccountId: stripeAccountId,
      sessionId: sessionId,
    );
    return paymentIntent.clientSecret;
  }

  @override
  Future<PaymentVerificationModel> verifyPayment({
    required String paymentIntentId,
    required String sessionId,
  }) async {
    return await _paymentDatasource.verifyPayment(
      paymentIntentId: paymentIntentId,
      sessionId: sessionId,
    );
  }
}
