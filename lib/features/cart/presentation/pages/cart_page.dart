import 'package:bingo/features/cart/presentation/pages/widgets/cart_empty_widget.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/cart_widget.dart';
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
          if (state is CartItemsLoadded) {
            return CartWidget(productModel: state.prodcutModel);
          } else if (state is EmptyCart) {
            return CartEmptyWidget();
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
