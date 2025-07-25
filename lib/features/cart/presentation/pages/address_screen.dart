import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/address_items_widget.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/cart_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';

class AddressScreen extends StatefulWidget {
  final double totalCartPrice;
  final int productModel;

  const AddressScreen({
    super.key,
    required this.totalCartPrice,
    required this.productModel,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int _selectedIndex = 0;
  final List<String> addresses = [
    'Department 7, Building 12, Apartment 5',
    'Department 3, Building 8, Apartment 12',
    'Department 9, Building 5, Apartment 3',
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    context.read<CartCubit>().getAllCartItems();
    var sizedBox = SizedBox(height: 16.h);
    var textStyle = Theme.of(context).textTheme.headlineMedium;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.address,
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
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.black12),
            child: Column(
              children: [
                Row(
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
                          '${widget.totalCartPrice.toString()} ${loc.egp}',
                          style: textStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return AddressItemsWidget(
                  address: addresses[index],
                  isSelected: _selectedIndex == index,
                  onSelect: () => setState(() => _selectedIndex = index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
