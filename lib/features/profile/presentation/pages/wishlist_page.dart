import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/features/home/presentaion/cubit/home_cubit.dart';
import 'package:bingo/features/home/presentaion/cubit/home_state.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/card_prodcut_item_widget.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/presentation/cubit/cart_cubit.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().getWishlistItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.wishlist),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(loc.clearWishlist),
                  content: Text(loc.areYouSureYouWantToClearYourWishlist),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(loc.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<HomeCubit>().clearWishlist();
                      },
                      child: Text(loc.clear),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is RemoveFromWishlistSuccess) {
            showAppSnackBar(context, state.message);
            // Refresh the wishlist
            context.read<HomeCubit>().getWishlistItems();
          } else if (state is ClearWishlistSuccess) {
            showAppSnackBar(context, state.message);
            context.read<HomeCubit>().getWishlistItems();
          } else if (state is AddToWishlistSuccess) {
            // Refresh the wishlist if an item was added
            context.read<HomeCubit>().getWishlistItems();
          }
        },
        builder: (context, state) {
          if (state is GetWishlistItemsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetWishlistItemsSuccess) {
            final products = state.products;

            if (products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      loc.yourWishlistIsEmpty,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 8),
                    Text(
                      loc.addItemsToYourWishlist,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/bottomNavBar'),
                      child: Text(loc.continueShopping),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.65,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return CardProdcutItemWidget(
                  cardOnTap: () => Navigator.pushNamed(
                    context,
                    '/product-details',
                    arguments: product,
                  ),
                  image: product.images ?? '',
                  name: product.title ?? "Product Name",
                  desc: product.shortDescription ?? "short description",
                  price: product.price ?? 0.0,
                  rating: product.ratings ?? 0,
                  isFavorite: true,
                  onChanged: (value) {
                    if (!value) {
                      context.read<HomeCubit>().removeFromWishlist(
                        product.id ?? '',
                      );
                    }
                  },
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
            );
          } else if (state is GetWishlistItemsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    loc.errorLoadingWishlist,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<HomeCubit>().getWishlistItems(),
                    child: Text(loc.tryAgain),
                  ),
                ],
              ),
            );
          }

          // Initial state or other states
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () => context.read<HomeCubit>().getWishlistItems(),
                  child: Text(loc.refreshWishlist),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
