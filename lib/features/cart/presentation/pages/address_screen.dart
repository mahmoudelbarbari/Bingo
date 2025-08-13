import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bingo/features/payment/presentation/pages/streamlined_payment_screen.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/add_new_address_btn.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/address_items_widget.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/cart_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/current_user_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/domain/entity/user.dart';
import '../../../profile/presentation/cubit/user_cubit/user_cubit.dart';
import '../../../profile/presentation/cubit/user_cubit/user_state.dart';

class AddressScreen extends StatefulWidget {
  final double totalCartPrice;
  final int productModel;
  final List<Map<String, dynamic>> cartItems;

  const AddressScreen({
    super.key,
    required this.totalCartPrice,
    required this.productModel,
    required this.cartItems,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int _selectedIndex = 0;
  String _userId = '';
  List<AddressEntity> _addresses = [];
  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
    // Fetch user addresses from UserCubit
    context.read<UserCubit>().getUserAddress(_userId);
    // Fetch cart items
    context.read<CartCubit>().getAllCartItems();
  }

  Future<void> _getCurrentUserId() async {
    final userId = await CurrentUserService.getCurrentUserId();
    setState(() {
      _userId = userId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    var sizedBox = SizedBox(height: 24.h);
    var textStyle = Theme.of(context).textTheme.headlineMedium;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          loc.address,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          sizedBox,
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
                isSelected: false,
              ),
            ],
          ),
          sizedBox,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(color: Colors.black12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(widget.productModel.toString(), style: textStyle),
                    SizedBox(width: 4.w),
                    Text(loc.items, style: textStyle),
                  ],
                ),
                Row(
                  children: [
                    Text('${loc.total} :', style: textStyle),
                    SizedBox(width: 7.w),
                    Text(
                      '${widget.totalCartPrice} ${loc.egp}',
                      style: textStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          sizedBox,
          Expanded(
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is AddUserAddressLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AddressLoadedState) {
                  final List<AddressEntity> addresses = state.addressEntity;
                  _addresses = state.addressEntity;
                  if (addresses.isEmpty) {
                    return Center(child: Text(loc.noAddressesFound));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    itemCount: addresses.length + 1,
                    itemBuilder: (context, index) {
                      if (index < addresses.length) {
                        final address = addresses[index];
                        final fullAddress =
                            '${address.name}, ${address.label}, ${address.streetAddress}, ${address.city}, , ${address.country}, ${address.zipCode}';

                        return AddressItemsWidget(
                          address: fullAddress,
                          isSelected: _selectedIndex == index,
                          onSelect: () =>
                              setState(() => _selectedIndex = index),
                        );
                      } else {
                        return AddNewAddressBtnWidget(title: loc.addNewAddress);
                      }
                    },
                  );
                } else if (state is AddressErrorState) {
                  return Center(child: Text(state.err));
                }
                return const SizedBox();
              },
            ),
          ),
          ElevatedButtonWidget(
            fun: () {
              if (_addresses.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please add an address first')),
                );
                return;
              }

              if (_selectedIndex >= _addresses.length) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select an address')),
                );
                return;
              }
              debugPrint('Cart items being sent: ${widget.cartItems}');
              final selectedAddressId = _addresses[_selectedIndex].id;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StreamlinedPaymentScreen(
                    totalAmount: widget.totalCartPrice,
                    addressId: selectedAddressId,
                  ),
                ),
              );
            },
            text: loc.confirm,
            isColored: true,
          ),
          sizedBox,
        ],
      ),
    );
  }
}
