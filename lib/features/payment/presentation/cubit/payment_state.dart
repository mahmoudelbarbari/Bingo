import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/payment_session_model.dart';

@immutable
abstract class PaymentState extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

// Checkout states
class CheckoutLoading extends PaymentState {}

class CheckoutSuccess extends PaymentState {
  final PaymentSessionModel session;

  CheckoutSuccess(this.session);

  @override
  List<Object> get props => [session];
}

class CheckoutError extends PaymentState {
  final String message;

  CheckoutError(this.message);

  @override
  List<Object> get props => [message];
}

// Payment Intent states
class PaymentIntentLoading extends PaymentState {}

class PaymentIntentCreated extends PaymentState {
  final PaymentIntentModel paymentIntent;
  final String sessionId;

  PaymentIntentCreated(this.paymentIntent, this.sessionId);

  @override
  List<Object> get props => [paymentIntent, sessionId];
}

class PaymentIntentError extends PaymentState {
  final String message;

  PaymentIntentError(this.message);

  @override
  List<Object> get props => [message];
}

// Payment Verification states
class PaymentVerificationLoading extends PaymentState {}

class PaymentVerificationSuccess extends PaymentState {
  final PaymentVerificationModel verification;

  PaymentVerificationSuccess(this.verification);

  @override
  List<Object> get props => [verification];
}

class PaymentVerificationError extends PaymentState {
  final String message;

  PaymentVerificationError(this.message);

  @override
  List<Object> get props => [message];
}

// Legacy states for backward compatibility
class PaymentSessionCreated extends PaymentState {
  final PaymentSessionModel session;

  PaymentSessionCreated(this.session);

  @override
  List<Object> get props => [session];
}

class PaymentError extends PaymentState {
  final String message;

  PaymentError(this.message);

  @override
  List<Object> get props => [message];
}
