import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/cart_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/current_user_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/cubit/user_cubit/user_cubit.dart';
import '../../../profile/presentation/cubit/user_cubit/user_state.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';
import 'package:bingo/features/cart/data/datasource/cart_datasource.dart';

class PaymentScreen extends StatelessWidget {
  final double totalAmount;
  final String? addressId;
  const PaymentScreen({super.key, required this.totalAmount, this.addressId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PaymentCubit()),
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return _PaymentView(totalAmount: totalAmount, addressId: addressId);
        },
      ),
    );
  }
}

class _PaymentView extends StatefulWidget {
  final double totalAmount;
  final String? addressId;
  const _PaymentView({required this.totalAmount, this.addressId});

  @override
  State<_PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<_PaymentView> {
  List<Map<String, dynamic>> cartItems = [];
  String? selectedAddressId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // First, use the addressId passed from the address screen
      if (widget.addressId != null) {
        selectedAddressId = widget.addressId;
        print('Using address ID from address screen: $selectedAddressId');
      }

      // Get cart items from Firebase
      final cartDatasource = CartDatasourceImpl();
      final cartProducts = await cartDatasource.getAllCartItems();

      print('Cart products from Firebase: ${cartProducts.length}');
      print(
        'Cart products details: ${cartProducts.map((p) => '${p.id}: ${p.title}').toList()}',
      );

      // Convert to the format expected by the payment API
      final convertedCartItems = cartProducts.map((product) {
        return {
          'productId': product.id,
          'quantity': 1, // You might need to get actual quantity from Firebase
          'price': product.salePrice ?? product.price ?? 0.0,
          'shopId': product.shopId,
          'productName': product.title,
          'productImage': product.image?.first['url'] ?? '',
        };
      }).toList();

      print('Converted cart items: $convertedCartItems');

      // If no address was passed, try to get from UserCubit
      if (selectedAddressId == null) {
        final userCubit = context.read<UserCubit>();
        final userId = await CurrentUserService.getCurrentUserId();
        if (userId != null) {
          await userCubit.getUserAddress(userId);

          // Wait a bit for the state to update
          await Future.delayed(Duration(milliseconds: 500));

          final userState = userCubit.state;
          if (userState is AddressLoadedState &&
              userState.addressEntity.isNotEmpty) {
            final defaultAddress = userState.addressEntity.firstWhere(
              (address) => address.isDefault == true,
              orElse: () => userState.addressEntity.first,
            );
            selectedAddressId = defaultAddress.id;
            print('Using default address ID: $selectedAddressId');
          }
        }
      }

      setState(() {
        cartItems = convertedCartItems;
        isLoading = false;
      });

      print('Final cart items: $cartItems');
      print('Final address ID: $selectedAddressId');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading data: $e')));
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
        body: const Center(child: CircularProgressIndicator()),
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
      body: Column(
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
            child: Center(
              child: BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, state) {
                  if (state is PaymentLoading) {
                    return CircularProgressIndicator();
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.credit_card, size: 64),
                      SizedBox(height: 16),
                      Text(
                        loc.securePayment,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 8),
                      Text(loc.paymentProcessing, textAlign: TextAlign.center),
                    ],
                  );
                },
              ),
            ),
          ),
          BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) {
              return ElevatedButtonWidget(
                fun: () {
                  // Debug prints
                  print('Cart items being sent to payment: $cartItems');
                  print('Address ID being sent: $selectedAddressId');

                  if (cartItems.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Cart is empty. Please add items first.'),
                      ),
                    );
                    return;
                  }

                  if (selectedAddressId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select an address first.'),
                      ),
                    );
                    return;
                  }

                  context.read<PaymentCubit>().createPaymentIntent(
                    amount: widget.totalAmount,
                    stripeAccountId: 'acct_1QZ882FJW8ocTpM8',
                    sessionId:
                        'cs_test_a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t1u2v3w4x5y6z7',
                  );
                },
                text:
                    '${loc.pay} ${widget.totalAmount.toStringAsFixed(2)} ${loc.egp}',
                isColored: true,
              );
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
