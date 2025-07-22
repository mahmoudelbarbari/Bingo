import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class FilterBtnWidget extends StatelessWidget {
  const FilterBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          ?isDark
              ? null
              : BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: ImageIcon(AssetImage(Assets.images.filter.path)),
      ),
    );
  }
}
