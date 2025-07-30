import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/colors_types.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_outlined_btn_widget.dart';
import 'package:bingo/features/home/domain/entity/categoriy_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class FilterSheetContent extends StatefulWidget {
  const FilterSheetContent({super.key});

  @override
  FilterSheetContentState createState() => FilterSheetContentState();
}

class FilterSheetContentState extends State<FilterSheetContent> {
  RangeValues _priceRange = RangeValues(250, 500);
  String? selectedColor;
  String? selectedSize;

  final List<String> colors = [
    'Red',
    'Blue',
    'Brown',
    'Orange',
    'Yellow',
    'Pink',
  ];
  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL'];
  final List<CategoriyEntity> categories = categoryList;
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;
    var divider = Divider(thickness: 0.5, endIndent: 10, indent: 10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            height: 5.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: lightTheme.colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        _buildSectionTitle(loc.categories),
        ...categories.map(
          (c) => ListTile(
            title: Text(c.name, style: Theme.of(context).textTheme.labelSmall),
            onTap: () => setState(() => selectedCategoryId = c.id),
            trailing: selectedCategoryId == c.id
                ? Icon(Icons.check, color: lightTheme.colorScheme.primary)
                : null,
          ),
        ),
        divider,

        _buildSectionTitle(loc.color),
        ...colors.map((color) {
          final colors = getColorFromName(color);
          return RadioListTile<String>(
            title: Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: colors,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedColor == color
                          ? (isDark ? Colors.white : Colors.black)
                          : Colors.black12,
                      width: selectedColor == color ? 2 : 1,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(color),
              ],
            ),
            value: color,
            groupValue: selectedColor,
            onChanged: (value) => setState(() => selectedColor = value),
          );
        }),
        divider,

        _buildSectionTitle(loc.size),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: sizes.map((size) {
              return ChoiceChip(
                label: Text(size),
                selected: selectedSize == size,
                onSelected: (_) => setState(() => selectedSize = size),
              );
            }).toList(),
          ),
        ),
        divider,

        _buildSectionTitle(loc.filterByPrice),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${_priceRange.start.round()}'),
            Text('${_priceRange.end.round()}'),
          ],
        ),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 1000,
          divisions: 100,
          onChanged: (values) => setState(() => _priceRange = values),
        ),

        SizedBox(height: 10),
        Center(
          child: CustomeOutlinedBtnWidget(
            text: loc.search,
            isSelected: false,
            onPressed: () {
              //TODO:: the fucntion that handle filter is here
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.w),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
