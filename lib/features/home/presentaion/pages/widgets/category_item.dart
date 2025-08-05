import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Color.fromARGB(240, 240, 240, 255),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(Assets.images.jewelry.path),
          ),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: Text(
            category,
            style: const TextStyle(fontSize: 12, overflow: TextOverflow.clip),
          ),
        ),
      ],
    );
  }
}
