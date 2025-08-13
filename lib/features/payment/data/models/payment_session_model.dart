// payment_session_model.dart
class PaymentSessionModel {
  final String sessionId;
  final double totalAmount;
  final String? shippingAddressId;
  final List<Map<String, dynamic>> cartItems;
  final Map<String, dynamic>? coupon;
  final List<Map<String, dynamic>> sellers;

  PaymentSessionModel({
    required this.sessionId,
    required this.totalAmount,
    this.shippingAddressId,
    required this.cartItems,
    this.coupon,
    required this.sellers,
  });

  factory PaymentSessionModel.fromJson(Map<String, dynamic> json) {
    return PaymentSessionModel(
      sessionId: json['sessionId'],
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      shippingAddressId: json['shippingAddressId'],
      cartItems: List<Map<String, dynamic>>.from(json['cartItems'] ?? []),
      coupon: json['coupon'] != null
          ? Map<String, dynamic>.from(json['coupon'])
          : null,
      sellers: List<Map<String, dynamic>>.from(json['sellers'] ?? []),
    );
  }

  // Factory constructor for backend response that only returns sessionId
  factory PaymentSessionModel.fromSessionId(String sessionId) {
    return PaymentSessionModel(
      sessionId: sessionId,
      totalAmount: 0.0,
      shippingAddressId: null,
      cartItems: [],
      coupon: null,
      sellers: [],
    );
  }

  // Add a method to get the first seller's Stripe account ID
  String? getFirstSellerStripeAccountId() {
    if (sellers.isNotEmpty) {
      return sellers.first['stripeAccountId'];
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'totalAmount': totalAmount,
      'shippingAddressId': shippingAddressId,
      'cartItems': cartItems,
      'coupon': coupon,
      'sellers': sellers,
    };
  }
}

// payment_intent_model.dart
class PaymentIntentModel {
  final String clientSecret;
  final String paymentIntentId;
  final String status;
  final double amount;

  PaymentIntentModel({
    required this.clientSecret,
    required this.paymentIntentId,
    required this.status,
    required this.amount,
  });

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    final clientSecret = json['clientSecret'];
    if (clientSecret == null) {
      throw Exception('Client secret is required but was null');
    }
    return PaymentIntentModel(
      clientSecret: clientSecret.toString(),
      paymentIntentId: json['paymentIntentId'] ?? '',
      status: json['status'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

// payment_verification_model.dart
class PaymentVerificationModel {
  final bool success;
  final String? errorMessage;
  final String? orderId;
  final String? transactionId;

  PaymentVerificationModel({
    required this.success,
    this.errorMessage,
    this.orderId,
    this.transactionId,
  });

  factory PaymentVerificationModel.fromJson(Map<String, dynamic> json) {
    return PaymentVerificationModel(
      success: json['success'] ?? false,
      errorMessage: json['errorMessage'],
      orderId: json['orderId'],
      transactionId: json['transactionId'],
    );
  }
}
