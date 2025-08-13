# Streamlined Payment Flow

This document describes the payment flow for the Bingo e-commerce application that matches the existing backend implementation.

## Flow Overview

The payment flow consists of 3 main steps:

1. **Create Payment Session** - Create payment session and validate cart
2. **Create Payment Intent** - Create Stripe payment intent
3. **Verify Payment Session** - Verify payment session and get session data

## Backend Endpoints

### 1. Create Payment Session (POST /create-payment-session)

Creates a payment session and validates the cart.

**Request Body:**

```json
{
  "cart": [
    {
      "id": "product_id",
      "quantity": 1,
      "sale_price": 100.0,
      "shopId": "shop_id",
      "selectedOptions": {}
    }
  ],
  "selectedAddressId": "address_id",
  "coupon": null
}
```

**Response:**

```json
{
  "sessionId": "session_uuid"
}
```

### 2. Create Payment Intent (POST /create-payment-intent)

Creates a Stripe payment intent for the session.

**Request Body:**

```json
{
  "amount": 100.0,
  "sellerStripeAccountId": "acct_xxx",
  "sessionId": "session_uuid"
}
```

**Response:**

```json
{
  "clientSecret": "pi_xxx_secret_xxx"
}
```

### 3. Verify Payment Session (GET /verify-payment-session)

Verifies the payment session and returns session data.

**Request:**

```
GET /verify-payment-session?sessionId=session_uuid
```

**Response:**

```json
{
  "success": true,
  "session": {
    "userId": "user_id",
    "cart": [...],
    "sellers": [...],
    "totalAmount": 100.0,
    "shippingAddressId": "address_id",
    "coupon": null
  }
}
```

## Frontend Implementation

### Payment Cubit Methods

```dart
// Step 1: Create Payment Session
await paymentCubit.checkout(
  cartItems: cartItems,
  addressId: addressId,
  coupon: coupon,
);

// Step 2: Create Payment Intent
await paymentCubit.createPaymentIntent(
  amount: totalAmount,
  stripeAccountId: sellerStripeAccountId,
  sessionId: sessionId,
);

// Step 3: Verify Payment Session
await paymentCubit.verifyPaymentSession(
  sessionId: sessionId,
);
```

### Payment States

- `CheckoutLoading` / `CheckoutSuccess` / `CheckoutError`
- `PaymentIntentLoading` / `PaymentIntentCreated` / `PaymentIntentError`
- `PaymentVerificationLoading` / `PaymentVerificationSuccess` / `PaymentVerificationError`

## Usage Example

```dart
// Navigate to the streamlined payment screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => StreamlinedPaymentScreen(
      totalAmount: cartTotal,
      addressId: selectedAddressId,
    ),
  ),
);
```

## Backend Implementation Notes

The backend implementation includes:

1. **Authentication**: All endpoints require authentication via `isAuthenticated` middleware
2. **Session Management**: Payment sessions are stored in Redis with TTL
3. **Cart Validation**: Validates cart items and calculates totals
4. **Stripe Integration**: Creates payment intents with platform fees
5. **Seller Management**: Handles multiple sellers and their Stripe accounts

## Error Handling

- Cart validation errors
- Payment intent creation failures
- Stripe API errors
- Session expiration
- Authentication errors

## Testing

1. Use Stripe test cards for development
2. Test with minimum order amounts (50 EGP)
3. Test session expiration scenarios
4. Test payment failures and retries
