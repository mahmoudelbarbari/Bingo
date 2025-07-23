import 'package:bingo/features/profile/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cart_cubit.dart';
import 'bottom_container_cart_widget.dart';
import 'cart_items_container.dart';

class CartWidget extends StatefulWidget {
  final List<ProductModel> productModel;
  const CartWidget({super.key, required this.productModel});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  Future<void> _refresh() async {
    setState(() {
      context.read<CartCubit>().getAllCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    double cartTotalPrice() {
      double total = 0;
      double delivartFee = 25.0;
      double serviceFee = 12.0;
      for (var item in widget.productModel) {
        double? price = item.price;
        total += price! + delivartFee + serviceFee;
      }
      return total;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              padding: const EdgeInsets.all(4),
              itemCount: widget.productModel.length,
              itemBuilder: (context, index) {
                const center = Center(
                  child: Divider(thickness: 0.5, indent: 5, endIndent: 5),
                );
                return CartItemsContainer(
                  center: center,
                  title: widget.productModel[index].name ?? '',
                  subTitle: widget.productModel[index].price,
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 0.5),
            ),
          ),
        ),
        BottomContainerCartWidget(total: cartTotalPrice()),
      ],
    );
  }
}
