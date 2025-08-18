import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final bool isSubcategory;

  const CategoryItem({
    super.key,
    required this.title,
    this.isSubcategory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isSubcategory
                  ? const Color.fromARGB(240, 230, 230, 245)
                  : const Color.fromARGB(240, 240, 240, 255),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              Assets.images.jewelry.path,
              width: isSubcategory ? 28.w : 36.w,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: isSubcategory ? 12 : 14),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
