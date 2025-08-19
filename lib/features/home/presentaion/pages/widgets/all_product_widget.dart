import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/features/home/presentaion/cubit/home_cubit.dart';
import 'package:bingo/features/home/presentaion/cubit/home_state.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/card_prodcut_item_widget.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:bingo/features/product/domain/entity/product.dart';
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

  @override
  void initState() {
    super.initState();
    // Check wishlist status for all products
    for (var product in widget.productEntity) {
      if (product.id != null) {
        context.read<HomeCubit>().checkIfInWishlist(product.id!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final homeCubit = context.read<HomeCubit>();
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (context, current) {
        return current is AddToWishlistSuccess ||
            current is RemoveFromWishlistSuccess ||
            current is IsInWishlistSuccess;
      },
      listener: (context, state) {
        setState(() {});
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loc.products,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.productEntity.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final product = widget.productEntity[index];
              final productId = product.id ?? '';
              final isInWishlist = homeCubit.isProductInWishlist(productId);
              return widget.productEntity.isNotEmpty
                  ? CardProdcutItemWidget(
                      cardOnTap: () => Navigator.pushNamed(
                        context,
                        '/product-details',
                        arguments: widget.productEntity[index],
                      ),
                      image: widget.productEntity[index].firstImageUrl,
                      name: widget.productEntity[index].title ?? "Product Name",
                      desc:
                          widget.productEntity[index].shortDescription ??
                          "short description",
                      price: widget.productEntity[index].price ?? 0.0,
                      rating: widget.productEntity[index].ratings ?? 0,
                      isFavorite: isInWishlist,
                      onChanged: (value) {
                        if (value) {
                          // Add to wishlist
                          homeCubit.addToWishlist(productId);
                        } else {
                          // Remove from wishlist
                          homeCubit.removeFromWishlist(productId);
                        }
                        setState(() {});
                      },
                      onTap: () {
                        showAppSnackBar(
                          context,
                          loc.addedToYourCart(
                            widget.productEntity[index].title ?? 'Product Name',
                          ),
                        );
                        context.read<CartCubit>().addProductToCart(
                          widget.productEntity[index] as ProductModel,
                        );
                      },
                    )
                  : Text(loc.thereSsNoProductAtThisMoment);
            },
          ),
        ],
      ),
    );
  }
}
