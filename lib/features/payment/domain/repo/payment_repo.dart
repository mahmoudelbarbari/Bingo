import '../../data/models/payment_session_model.dart';

abstract class PaymentRepo {
  // Create payment session (matches backend endpoint)
  Future<PaymentSessionModel> createPaymentSession({
    required List<Map<String, dynamic>> cartItems,
    String? addressId,
    String? coupon,
  });

  // Create payment intent (matches backend endpoint)
  Future<PaymentIntentModel> createPaymentIntent({
    required double amount,
    required String stripeAccountId,
    required String sessionId,
  });

  // Verify payment session (matches backend endpoint)
  Future<PaymentVerificationModel> verifyPaymentSession({
    required String sessionId,
  });

  // Legacy methods for backward compatibility
  Future<PaymentSessionModel> checkout({
    required List<Map<String, dynamic>> cartItems,
    String? addressId,
    String? coupon,
  });

  Future<String> createPaymentIntentLegacy({
    required double amount,
    required String stripeAccountId,
    required String sessionId,
  });

  Future<PaymentVerificationModel> verifyPayment({
    required String paymentIntentId,
    required String sessionId,
  });
}
