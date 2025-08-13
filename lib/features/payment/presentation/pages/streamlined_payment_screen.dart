import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart'
    hide Card, PaymentIntentError;
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/cart_progress_widget.dart';
import 'package:bingo/features/cart/data/datasource/cart_datasource.dart';
import 'package:bingo/core/service/current_user_service.dart';
import 'package:bingo/l10n/app_localizations.dart';
import '../../../profile/presentation/cubit/user_cubit/user_cubit.dart';
import '../../../profile/presentation/cubit/user_cubit/user_state.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';
import '../../data/models/payment_session_model.dart';

class StreamlinedPaymentScreen extends StatefulWidget {
  final double totalAmount;
  final String? addressId;

  const StreamlinedPaymentScreen({
    super.key,
    required this.totalAmount,
    this.addressId,
  });

  @override
  State<StreamlinedPaymentScreen> createState() =>
      _StreamlinedPaymentScreenState();
}

class _StreamlinedPaymentScreenState extends State<StreamlinedPaymentScreen> {
  List<Map<String, dynamic>> cartItems = [];
  String? selectedAddressId;
  bool isLoading = true;
  PaymentSessionModel? currentSession;
  PaymentIntentModel? currentPaymentIntent;
  CardFormEditController cardController = CardFormEditController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    cardController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      // Use the addressId passed from the address screen
      if (widget.addressId != null) {
        selectedAddressId = widget.addressId;
        print('Using address ID from address screen: $selectedAddressId');
      }

      // Get cart items from Firebase
      final cartDatasource = CartDatasourceImpl();
      final cartProducts = await cartDatasource.getAllCartItems();

      print('Cart products from Firebase: ${cartProducts.length}');

      // Convert to the format expected by the payment API
      final convertedCartItems = cartProducts.map((product) {
        return {
          'id': product.id,
          'quantity': 1, // You might need to get actual quantity from Firebase
          'sale_price': product.salePrice ?? product.price ?? 0.0,
          'shopId': product.shopId,
          'title': product.title,
          'selectedOptions': {},
        };
      }).toList();

      setState(() {
        cartItems = convertedCartItems;
        isLoading = false;
      });

      // If no address was passed, try to get from UserCubit
      if (selectedAddressId == null) {
        final userCubit = context.read<UserCubit>();
        final userId = await CurrentUserService.getCurrentUserId();
        if (userId != null) {
          await userCubit.getUserAddress(userId);
          await Future.delayed(Duration(milliseconds: 500));

          final userState = userCubit.state;
          if (userState is AddressLoadedState &&
              userState.addressEntity.isNotEmpty) {
            setState(() {
              selectedAddressId = userState.addressEntity.first.id;
            });
          }
        }
      }
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _proceedToCheckout() async {
    if (cartItems.isEmpty) {
      showAppSnackBar(
        context,
        'Cart is empty. Please add items first.',
        isError: true,
      );
      return;
    }

    if (selectedAddressId == null) {
      showAppSnackBar(
        context,
        'Please select an address first.',
        isError: true,
      );
      return;
    }

    context.read<PaymentCubit>().checkout(
      cartItems: cartItems,
      addressId: selectedAddressId,
      coupon: null, // Add coupon logic if needed
    );
  }

  Future<void> _createPaymentIntent() async {
    if (currentSession == null) {
      showAppSnackBar(
        context,
        'No active session found. Please checkout first.',
        isError: true,
      );
      return;
    }

    // Try to get seller's Stripe account ID from session first
    String? stripeAccountId = currentSession!.getFirstSellerStripeAccountId();

    // If not found in session, try to get from cart items
    if (stripeAccountId == null && cartItems.isNotEmpty) {
      // Get the shopId from the first cart item
      final firstItem = cartItems.first;
      final shopId = firstItem['shopId'];

      // Try to get seller's Stripe account ID by shopId
      stripeAccountId = await _getStripeAccountIdByShopId(shopId);
    }

    // If still not found, use a default account ID (for testing)
    if (stripeAccountId == null) {
      stripeAccountId = 'acct_1RufTGFPZnB6OJbb'; // Your default test account
      print('Using default Stripe account ID: $stripeAccountId');
    }

    print('Creating payment intent with:');
    print('- Amount: ${widget.totalAmount}');
    print('- Stripe Account ID: $stripeAccountId');
    print('- Session ID: ${currentSession!.sessionId}');

    context.read<PaymentCubit>().createPaymentIntent(
      amount: widget.totalAmount,
      stripeAccountId: stripeAccountId,
      sessionId: currentSession!.sessionId,
    );
  }

  // Add this method to fetch seller's Stripe account ID by shopId
  Future<String?> _getStripeAccountIdByShopId(String shopId) async {
    try {
      // You can create an API endpoint to get seller's Stripe account ID by shopId
      // For now, return null to use the fallback
      print('Attempting to get Stripe account ID for shop: $shopId');

      // TODO: Implement API call to get seller's Stripe account ID
      // Example:
      // final dio = await DioClient.createDio(ApiTarget.seller);
      // final response = await dio.get('sellers/$shopId/stripe-account');
      // return response.data['stripeAccountId'];

      return null;
    } catch (e) {
      print('Error getting Stripe account ID for shop $shopId: $e');
      return null;
    }
  }

  Future<void> _processPayment() async {
    if (currentPaymentIntent == null) {
      showAppSnackBar(context, 'No payment intent found', isError: true);
      return;
    }

    try {
      // 1. First initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: currentPaymentIntent!.clientSecret,
          merchantDisplayName: 'Bingo',
          style: ThemeMode.light,
          customerId: await CurrentUserService.getCurrentUserId(),
          customerEphemeralKeySecret: null,
        ),
      );

      // 2. Then present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      // 3. Handle successful payment
      context.read<PaymentCubit>().verifyPaymentSession(
        sessionId: currentSession!.sessionId,
      );
    } on StripeException catch (e) {
      showAppSnackBar(
        context,
        'Payment failed: ${e.error.localizedMessage}',
        isError: true,
      );
    } catch (e) {
      showAppSnackBar(context, 'Unexpected error: $e', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            loc.payment,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          loc.payment,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is CheckoutSuccess) {
            setState(() {
              currentSession = state.session;
            });
            showAppSnackBar(context, 'Checkout successful!');
          } else if (state is PaymentIntentCreated) {
            setState(() {
              currentPaymentIntent = state.paymentIntent;
            });
            showAppSnackBar(context, 'Payment intent created!');
          } else if (state is PaymentVerificationSuccess) {
            if (state.verification.success) {
              showAppSnackBar(context, 'Payment successful! Session verified.');
              // Navigate to success page or order confirmation
              Navigator.of(context).pop(true); // Return success
            } else {
              showAppSnackBar(
                context,
                'Payment verification failed: ${state.verification.errorMessage}',
                isError: true,
              );
            }
          } else if (state is CheckoutError ||
              state is PaymentIntentError ||
              state is PaymentVerificationError) {
            String errorMessage = '';
            if (state is CheckoutError)
              errorMessage = state.message;
            else if (state is PaymentIntentError)
              errorMessage = state.message;
            else if (state is PaymentVerificationError)
              errorMessage = state.message;

            showAppSnackBar(context, 'Error: $errorMessage', isError: true);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CartProgressWidget(
                    title: loc.order,
                    icon: Icons.shopping_cart_sharp,
                    isSelected: true,
                  ),
                  CartProgressWidget(
                    title: loc.address,
                    icon: Icons.location_city,
                    isSelected: true,
                  ),
                  CartProgressWidget(
                    title: loc.payment,
                    icon: Icons.payment_outlined,
                    isSelected: true,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Order Summary
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Summary',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Total Amount: ${widget.totalAmount.toStringAsFixed(2)} EGP',
                              ),
                              Text('Items: ${cartItems.length}'),
                              if (selectedAddressId != null)
                                Text('Address: $selectedAddressId'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Step 1: Checkout Button
                      if (currentSession == null)
                        ElevatedButtonWidget(
                          fun: _proceedToCheckout,
                          text: 'Step 1: Checkout',
                          isColored: true,
                        ),

                      // Step 2: Create Payment Intent Button
                      if (currentSession != null &&
                          currentPaymentIntent == null)
                        ElevatedButtonWidget(
                          fun: _createPaymentIntent,
                          text: 'Step 2: Create Payment Intent',
                          isColored: true,
                        ),

                      // Step 3: Payment Form
                      if (currentPaymentIntent != null) ...[
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment Information',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                SizedBox(height: 16.h),
                                CardFormField(
                                  controller: cardController,
                                  style: CardFormStyle(
                                    borderColor: Colors.grey,
                                    borderRadius: 8,
                                    fontSize: 16,
                                    placeholderColor: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                ElevatedButtonWidget(
                                  fun: _processPayment,
                                  text:
                                      'Step 3: Pay ${widget.totalAmount.toStringAsFixed(2)} EGP',
                                  isColored: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                      // Loading States
                      if (state is CheckoutLoading ||
                          state is PaymentIntentLoading ||
                          state is PaymentVerificationLoading)
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
