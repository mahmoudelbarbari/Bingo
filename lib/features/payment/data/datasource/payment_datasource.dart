import 'package:dio/dio.dart';

import '../../../../core/network/dio_provider.dart';
import '../models/payment_session_model.dart';

abstract class PaymentDatasource {
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

  Future<PaymentVerificationModel> verifyPayment({
    required String paymentIntentId,
    required String sessionId,
  });
}

class PaymentDatasourceImpl implements PaymentDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.order);

  @override
  Future<PaymentIntentModel> createPaymentIntent({
    required double amount,
    required String stripeAccountId,
    required String sessionId,
  }) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.post(
        'create-payment-intent',
        data: {
          'amount': amount,
          'sellerStripeAccountId': stripeAccountId,
          'sessionId': sessionId,
        },
      );

      // Backend returns only clientSecret, so we need to create the model
      return PaymentIntentModel(
        clientSecret: response.data['clientSecret'],
        paymentIntentId: '', // Not provided by backend
        status: 'requires_payment_method', // Default status
        amount: amount,
      );
    } catch (e) {
      throw ('Something went wrong ${e.toString()}');
    }
  }

  @override
  Future<PaymentSessionModel> createPaymentSession({
    required List<Map<String, dynamic>> cartItems,
    String? addressId,
    String? coupon,
  }) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.post(
        'create-payment-session',
        data: {
          'cart': cartItems,
          'selectedAddressId': addressId,
          'coupon': coupon,
        },
      );

      // If backend returns full session data, use it
      if (response.data.containsKey('sellers')) {
        return PaymentSessionModel.fromJson(response.data);
      } else {
        // If backend only returns sessionId, create a session with cart data
        final sessionId = response.data['sessionId'];
        return PaymentSessionModel(
          sessionId: sessionId,
          totalAmount: 0.0, // Will be calculated by backend
          shippingAddressId: addressId,
          cartItems: cartItems,
          coupon: coupon != null ? {'code': coupon} : null,
          sellers: [], // Will be populated when we get seller data
        );
      }
    } catch (e) {
      throw ('Something went wrong ${e.toString()}');
    }
  }

  @override
  Future<PaymentVerificationModel> verifyPaymentSession({
    required String sessionId,
  }) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get(
        'verify-payment-session',
        queryParameters: {'sessionId': sessionId},
      );

      // Backend returns session data
      response.data['session'];
      return PaymentVerificationModel(
        success: response.data['success'],
        orderId: null, // Not provided by this endpoint
        transactionId: null, // Not provided by this endpoint
        errorMessage: null,
      );
    } catch (e) {
      throw ('Something went wrong ${e.toString()}');
    }
  }

  @override
  Future<PaymentSessionModel> checkout({
    required List<Map<String, dynamic>> cartItems,
    String? addressId,
    String? coupon,
  }) async {
    // Legacy method - now calls createPaymentSession
    return await createPaymentSession(
      cartItems: cartItems,
      addressId: addressId,
      coupon: coupon,
    );
  }

  @override
  Future<PaymentVerificationModel> verifyPayment({
    required String paymentIntentId,
    required String sessionId,
  }) async {
    // This method is not implemented in the backend
    // You might need to implement this or use a different approach
    throw UnimplementedError('verifyPayment endpoint not available in backend');
  }
}
