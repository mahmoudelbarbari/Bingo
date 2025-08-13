import 'dart:async';
import 'package:bingo/features/payment/domain/usecase/create_payment_session_usecase.dart';
import 'package:bingo/features/payment/presentation/cubit/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection_container.dart';
import '../../domain/usecase/create_payment_intent_usecase.dart';
import '../../domain/usecase/checkout_usecase.dart';
import '../../domain/usecase/verify_payment_usecase.dart';

class PaymentCubit extends Cubit<PaymentState> {
  late CreatePaymentIntentUsecase createPaymentIntentUsecase;
  late CreatePaymentSessionUsecase createPaymentSessionUsecase;
  late CheckoutUsecase checkoutUsecase;
  late VerifyPaymentUsecase verifyPaymentUsecase;

  PaymentCubit() : super(PaymentInitial());

  // New streamlined payment flow methods

  /// Step 1: Checkout - Create payment session
  Future<void> checkout({
    required List<Map<String, dynamic>> cartItems,
    String? addressId,
    String? coupon,
  }) async {
    checkoutUsecase = sl();
    emit(CheckoutLoading());
    try {
      final session = await checkoutUsecase.call(cartItems, addressId, coupon);

      emit(CheckoutSuccess(session));
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }

  /// Step 2: Create payment intent
  Future<void> createPaymentIntent({
    required double amount,
    required String stripeAccountId,
    required String sessionId,
  }) async {
    createPaymentIntentUsecase = sl();
    emit(PaymentIntentLoading());
    try {
      final paymentIntent = await createPaymentIntentUsecase.call(
        amount,
        stripeAccountId,
        sessionId,
      );

      emit(PaymentIntentCreated(paymentIntent, sessionId));
    } catch (e) {
      emit(PaymentIntentError(e.toString()));
    }
  }

  /// Step 3: Verify payment session
  Future<void> verifyPaymentSession({required String sessionId}) async {
    verifyPaymentUsecase = sl();
    emit(PaymentVerificationLoading());
    try {
      final verification = await verifyPaymentUsecase.call(sessionId);

      emit(PaymentVerificationSuccess(verification));
    } catch (e) {
      emit(PaymentVerificationError(e.toString()));
    }
  }

  // Legacy methods for backward compatibility

  Future<void> createPaymentSession({
    required List<Map<String, dynamic>> cartItems,
    String? addressId,
    String? coupon,
  }) async {
    createPaymentSessionUsecase = sl();
    emit(PaymentLoading());
    try {
      final session = await createPaymentSessionUsecase.call(
        cartItems,
        addressId,
        coupon,
      );

      emit(PaymentSessionCreated(session));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> createPaymentIntentLegacy({
    required double amount,
    required String stripeAccountId,
    required String sessionId,
  }) async {
    createPaymentIntentUsecase = sl();
    emit(PaymentLoading());
    try {
      final paymentIntent = await createPaymentIntentUsecase.call(
        amount,
        stripeAccountId,
        sessionId,
      );

      emit(PaymentIntentCreated(paymentIntent, sessionId));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}
