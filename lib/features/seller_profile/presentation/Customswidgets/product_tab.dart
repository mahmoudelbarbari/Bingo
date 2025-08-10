import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import 'ProductCard.dart';

class ProductsTab extends StatelessWidget {
  final List<Product> products;

  const ProductsTab({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('لا يوجد منتجات'));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            price: '${product.price} EGP',
            oldPrice: '${product.oldPrice} EGP',
            rating: product.rating,
          );
        },
      ),
    );
  }
}
