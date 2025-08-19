import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

class CardProdcutItemWidget extends StatelessWidget {
  final String name;
  final String desc;
  final String image;
  final double price;
  final int rating;
  final void Function()? onTap;
  final void Function()? cardOnTap;
  final bool isFavorite;
  final ValueChanged<bool> onChanged;

  const CardProdcutItemWidget({
    super.key,
    required this.name,
    required this.desc,
    required this.image,
    required this.price,
    required this.isFavorite,
    required this.onChanged,
    required this.rating,
    this.onTap,
    this.cardOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cardOnTap,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageHeight = constraints.maxHeight * 0.55;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Container(
                      //   height: imageHeight,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8),
                      //     image: DecorationImage(
                      //       image: AssetImage(image),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: double.infinity,
                        height: imageHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                              (image.startsWith('http') ||
                                  image.startsWith('https'))
                              ? Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.broken_image);
                                  },
                                )
                              : const Icon(Icons.image_not_supported),
                        ),
                      ),
                      Positioned(
                        top: 8.h,
                        right: 7.w,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            onTap: () => onChanged(!isFavorite),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.black,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Expanded content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              desc,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber),
                                SizedBox(width: 4.w),
                                Text(
                                  rating.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: onTap,
                                icon: const Icon(
                                  Icons.shopping_cart_checkout_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
