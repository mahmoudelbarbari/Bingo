// Create a new file product_list_item.dart
import 'package:bingo/features/product/domain/entity/product.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  final ProductEntity product;

  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title ?? ''),
      subtitle: Text('${product.slug}'),
      onTap: () {},
    );
  }
}
