import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/home/presentaion/cubit/home_cubit.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../core/widgets/custome_snackbar_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../../product/domain/entity/product.dart';
import '../../cubit/home_state.dart';

class SlideShowHomeWidget extends StatelessWidget {
  const SlideShowHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        // Only rebuild for product-related states
        return current is ThreeProductsLoading ||
            current is ThreeProductsLoaded ||
            current is ThreeProductsError ||
            current is CombinedState;
      },
      builder: (context, state) {
        if (state is ThreeProductsLoading) {
          return SizedBox(
            height: 200.h,
            child: Center(child: CircularProgressIndicator()),
          );
        } // Extract products from either state
        List<ProductEntity> products = [];
        if (state is ThreeProductsLoaded) {
          products = state.products;
        } else if (state is CombinedState) {
          products = state.products;
        } // Handle error state (only if no products available)
        if (state is ThreeProductsError && products.isEmpty) {
          return SizedBox(
            height: 200.h,
            child: Center(child: Text('Error: ${state.message}')),
          );
        }

        // Show products if available
        if (products.isNotEmpty) {
          return _buildProductSlider(context, products);
        } else {
          return SizedBox(
            height: 200.h,
            child: Center(
              child: Text(AppLocalizations.of(context)!.noProductYet),
            ),
          );
        }
      },
    );
  }

  Widget _buildProductSlider(
    BuildContext context,
    List<ProductEntity> products,
  ) {
    final pageController = Provider.of<PageController>(context);
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      height: 280.h,
      child: Column(
        children: [
          SizedBox(
            height: 240.h,
            child: PageView.builder(
              controller: pageController,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:
                            (product.firstImageUrl.startsWith('http') ||
                                product.firstImageUrl.startsWith('https'))
                            ? Image.network(
                                product.firstImageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity.h,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image);
                                },
                              )
                            : Image.asset(
                                Assets.images.proPlanImg.path,
                                fit: BoxFit.cover,
                              ),
                      ),
                      // Gradient overlay for better text visibility
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      // Product name and price
                      Positioned(
                        top: 16.h,
                        left: 16.w,
                        right: 16.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title ??
                                  '', // Assuming your ProductEntity has name
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '\$${product.price}', // Assuming your ProductEntity has price
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Add to cart button
                      Positioned(
                        bottom: 16.h,
                        right: 16.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: lightTheme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                          ),
                          onPressed: () {
                            showAppSnackBar(
                              context,
                              loc.addedToYourCart(
                                products[index].title ?? 'Product Name',
                              ),
                            );
                            context.read<CartCubit>().addProductToCart(
                              products[index] as ProductModel,
                            );
                          },
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8.h),
          // Page indicator
          _buildPageIndicator(context, products.length),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(BuildContext context, int itemCount) {
    final pageController = Provider.of<PageController>(context);
    return StatefulBuilder(
      builder: (context, setState) {
        // Initialize with current page
        int currentPage = pageController.page?.round() ?? 0;

        // Add page change listener
        pageController.addListener(() {
          final newPage = pageController.page?.round() ?? 0;
          if (newPage != currentPage) {
            setState(() {
              currentPage = newPage;
            });
          }
        });
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            itemCount,
            (index) => Container(
              width: 8.w,
              height: 8.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index
                    ? lightTheme.colorScheme.primary
                    : Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
