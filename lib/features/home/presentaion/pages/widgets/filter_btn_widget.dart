import 'package:bingo/features/home/presentaion/pages/widgets/filter_sheet_content.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class FilterBtnWidget extends StatefulWidget {
  const FilterBtnWidget({super.key});

  @override
  State<FilterBtnWidget> createState() => _FilterBtnWidgetState();
}

class _FilterBtnWidgetState extends State<FilterBtnWidget> {
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
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 0.5, // Take 50% of screen height
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child:
                        FilterSheetContent(), // Move your filter UI into a new widget
                  ),
                ),
              );
            },
          );
        },
        child: ImageIcon(AssetImage(Assets.images.filter.path)),
      ),
    );
  }
}
