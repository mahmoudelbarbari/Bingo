import 'package:bingo/features/profile/data/model/product_model.dart';
import 'package:bingo/gen/assets.gen.dart';
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

  Map<String, int> itemCounts = {};
  double deliveryFee = 25.0;
  double serviceFee = 12.0;

  void _updateItemPrice(String itemId, int count, double total) {
    setState(() {
      itemCounts[itemId] = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    double cartTotalPrice() {
      double total = 0;
      for (var item in widget.productModel) {
        int count = itemCounts[item.id ?? ''] ?? 1;
        double? price = item.price;
        total += (price! * count) + deliveryFee + serviceFee;
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
            child: ListView.builder(
              itemCount: widget.productModel.length,
              itemBuilder: (context, index) {
                const center = Center(
                  child: Divider(thickness: 0.5, indent: 5, endIndent: 5),
                );
                return CartItemsContainer(
                  key: ValueKey(widget.productModel[index].id),
                  center: center,
                  image: Assets.images.noConnection.path,
                  title: widget.productModel[index].name ?? '',
                  desc: widget.productModel[index].shortDescription ?? "",
                  proPrice: widget.productModel[index].price,
                  onPriceUpdate: (count, total) => _updateItemPrice(
                    widget.productModel[index].id ?? "",
                    count,
                    total,
                  ),
                  proId: widget.productModel[index].name,
                );
              },
            ),
          ),
        ),
        BottomContainerCartWidget(
          total: cartTotalPrice(),
          productModel: widget.productModel.length,
        ),
      ],
    );
  }
}
