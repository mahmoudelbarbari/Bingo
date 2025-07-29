import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/card_prodcut_item_widget.dart';
import 'package:bingo/features/profile/data/model/product_model.dart';
import 'package:bingo/features/profile/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:bingo/features/profile/domain/entity/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cart/presentation/cubit/cart_cubit.dart';

class AllProductWidget extends StatefulWidget {
  final List<ProductEntity> productEntity;

  const AllProductWidget({super.key, required this.productEntity});

  @override
  State<AllProductWidget> createState() => _AllProductWidgetState();
}

class _AllProductWidgetState extends State<AllProductWidget> {
  Map<int, bool> favorites = {};

  Future<void> _refresh() async {
    setState(() {
      context.read<ProductCubit>().getAllProduct();
    });
    return Future.delayed(const Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;
    final isTablet = screenWidth > 600;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: GridView.builder(
        itemCount: widget.productEntity.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 3 : 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return CardProdcutItemWidget(
            cardOnTap: () => Navigator.pushNamed(
              context,
              '/product-details',
              arguments: widget.productEntity[index],
            ),
            // image: widget.productEntity[index].image ?? "",
            image: Assets.images.onboadring12.path,
            name: widget.productEntity[index].name ?? "Product Name",
            desc:
                widget.productEntity[index].shortDescription ??
                "short description",
            price: widget.productEntity[index].price ?? 0.0,
            isFavorite: favorites[index] ?? false,
            onChanged: (value) {
              setState(() {
                favorites[index] = value;
              });
            },
            onTap: () {
              showAppSnackBar(
                context,
                loc.addedToYourCart(
                  widget.productEntity[index].name ?? 'Product Name',
                ),
              );
              context.read<CartCubit>().addProductToCart(
                widget.productEntity[index] as ProductModel,
              );
            },
          );
        },
      ),
    );
  }
}
