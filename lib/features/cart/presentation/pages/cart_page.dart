import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/cart_empty_widget.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/cart_progress_widget.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/cart_widget.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getAllCartItems(),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            if (kDebugMode) {
              print(state.errorMessage);
            }
          }
        },
        builder: (context, state) {
          final loc = AppLocalizations.of(context)!;
          if (state is CartItemsLoadded) {
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 16.h),
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
                        isSelected: false,
                      ),
                      CartProgressWidget(
                        title: loc.payment,
                        icon: Icons.payment_outlined,
                        isSelected: false,
                      ),
                    ],
                  ),
                  Expanded(child: CartWidget(productModel: state.prodcutModel)),
                ],
              ),
            );
          }
          if (state is ItemDeletedSuccess) {
            context.read<CartCubit>().getAllCartItems();
          } else if (state is EmptyCart) {
            return CartEmptyWidget();
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
