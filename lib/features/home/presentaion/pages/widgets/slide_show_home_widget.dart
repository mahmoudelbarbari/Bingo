import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

class SlideShowHomeWidget extends StatelessWidget {
  SlideShowHomeWidget({super.key});

  final List<String> imageUrls = [
    'https://www.messoanuovo.it/cdn/shop/articles/PC-gaming-scaled.jpg?v=1707413030',
    "https://www.estre.in/cdn/shop/files/1-min_1a7b23d8-e00c-4bca-86fe-9c65a55bcd1d.jpg?v=1743763633",
    "https://d2ati23fc66y9j.cloudfront.net/category-pages/sub_category-174021874143.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}
