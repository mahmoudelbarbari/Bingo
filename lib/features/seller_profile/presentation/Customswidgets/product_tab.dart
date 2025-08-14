import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/size_config.dart';
import '../../domain/entities/product.dart';
import 'ProductCard.dart';

class ProductsTab extends StatelessWidget {
  final List<Product> products;

  const ProductsTab({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (products.isEmpty) {
      return Center(child: Text(loc.noProductYet));
    }

    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            imageUrl: product.imageUrl,
            title: product.name,
            description: product.description,
            price: '${product.price} ${loc.egp}',
            oldPrice: '${product.oldPrice} ${loc.egp}',
            rating: product.rating,
          );
        },
      ),
    );
  }
}
