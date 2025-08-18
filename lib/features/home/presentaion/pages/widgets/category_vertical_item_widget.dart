import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CategoryVerticalItemWidget extends StatelessWidget {
  final String category;
  final List<String> subcategories;

  const CategoryVerticalItemWidget({
    super.key,
    required this.category,
    required this.subcategories,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(category),
          leading: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Image.asset(Assets.images.jewelry.path),
          ),
        ),
        if (subcategories.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 72.w),
            child: Column(
              children: subcategories
                  .map(
                    (subcategory) => ListTile(
                      title: Text(
                        subcategory,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      leading: Container(
                        width: 40.w,
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(240, 230, 230, 245),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          Assets.images.jewelry.path,
                          width: 20.w,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
