// shop_details_screen.dart
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/home/presentaion/cubit/home_state.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:bingo/features/seller_profile/presentation/Customswidgets/profile_header.dart';
import 'package:bingo/features/shops/domain/entity/shop_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custome_snackbar_widget.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../seller_profile/presentation/Customswidgets/ButtonSaller.dart';
import '../cubit/home_cubit.dart';
import 'widgets/card_prodcut_item_widget.dart';

class ShopDetailsScreen extends StatefulWidget {
  final ShopEntity shop;

  const ShopDetailsScreen({super.key, required this.shop});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  Map<int, bool> favorites = {};

  @override
  void initState() {
    super.initState();
    // Check wishlist status for all products
    if (widget.shop.products != null) {
      for (var product in widget.shop.products!) {
        if (product.id != null) {
          context.read<HomeCubit>().checkIfInWishlist(product.id!);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final homeCubit = context.read<HomeCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(widget.shop.name ?? 'Test test')),
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddToWishlistSuccess ||
              state is RemoveFromWishlistSuccess ||
              state is IsInWishlistSuccess) {
            setState(() {});
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shop info section
              ProfileHeader(
                coverImageUrl: widget.shop.avatarUrl ?? '',
                profileImageUrl: widget.shop.avatarUrl ?? '',
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.shop.name ?? 'test test',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (widget.shop.bio != null) SizedBox(height: 4.h),
                        if (widget.shop.bio != null)
                          Text(
                            widget.shop.bio!,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    if (widget.shop.address != null)
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16.w),
                          SizedBox(width: 8.w),
                          Text('${loc.address}: ${widget.shop.address!}'),
                          Spacer(),
                          Icon(Icons.star, size: 16.w, color: Colors.orange),
                          SizedBox(width: 8.w),
                          Text('${loc.ratings}: ${widget.shop.rating}'),
                        ],
                      ),
                    if (widget.shop.openingHours != null) SizedBox(height: 8.h),
                    if (widget.shop.openingHours != null)
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 16.w),
                          SizedBox(width: 8.w),
                          Text(
                            '${loc.openingHours}: ${widget.shop.openingHours}',
                          ),
                        ],
                      ),
                    SizedBox(height: 16.h),
                    ButtonSeller(),
                  ],
                ),
              ),
              Divider(),
              // Products section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Text(
                  loc.products,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.shop.products?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final product = widget.shop.products![index];
                  final productId = product.id ?? '';
                  final isInWishlist = homeCubit.isProductInWishlist(productId);
                  return CardProdcutItemWidget(
                    cardOnTap: () => Navigator.pushNamed(
                      context,
                      '/product-details',
                      arguments: product,
                    ),
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
                    image: product.firstImageUrl,
                    name: product.title ?? '',
                    price: product.salePrice ?? 0.0,
                    desc: product.shortDescription ?? '',
                    rating: product.ratings ?? 0,
                    onTap: () {
                      showAppSnackBar(
                        context,
                        loc.addedToYourCart(product.title ?? 'Product Name'),
                      );
                      context.read<CartCubit>().addProductToCart(
                        product as ProductModel,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
