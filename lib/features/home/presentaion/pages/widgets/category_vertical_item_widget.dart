import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CategoryVerticalItemWidget extends StatelessWidget {
  final String category;
  const CategoryVerticalItemWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: ListTile(
        title: Text(category),
        leading: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: Color.fromARGB(240, 240, 240, 255),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(Assets.images.jewelry.path),
        ),
      ),
    );
  }
}
