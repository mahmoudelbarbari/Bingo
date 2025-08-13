import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/util/validators.dart';
import 'package:bingo/core/widgets/custom_textfield_for_instructions.dart';
import 'package:bingo/core/widgets/custome_textfield_widget.dart';
import 'package:bingo/features/product/presentation/pages/widgets/category_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/util/colors_types.dart';
import '../../../../../l10n/app_localizations.dart';

class AddProdcutForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController shortDescriptionController;
  final TextEditingController tagController;
  final TextEditingController warranty;
  final TextEditingController slugController;
  final TextEditingController brandController;
  final TextEditingController customPropertiesController;
  final TextEditingController videoURLController;
  final TextEditingController regularPriceController;
  final TextEditingController salePriceController;
  final TextEditingController stockController;
  final TextEditingController detailedDescriptionController;
  final TextEditingController paymentOptionController;
  final bool isArabic;
  final Function(List<String>, List<String>)? onCategorySelected;
  final Function(Set<String>)? onColorsSelected;
  final Function(Set<String>)? onSizesSelected;

  const AddProdcutForm({
    super.key,
    required this.titleController,
    required this.brandController,
    required this.customPropertiesController,
    required this.detailedDescriptionController,
    required this.isArabic,
    required this.regularPriceController,
    required this.salePriceController,
    required this.shortDescriptionController,
    required this.slugController,
    required this.stockController,
    required this.tagController,
    required this.videoURLController,
    required this.warranty,
    required this.paymentOptionController,
    this.onCategorySelected,
    this.onColorsSelected,
    this.onSizesSelected,
  });

  @override
  State<AddProdcutForm> createState() => _AddProdcutFormState();
}

class _AddProdcutFormState extends State<AddProdcutForm> {
  Set<String> selectedColors = {};
  Set<String> selectedSizes = {};
  bool showTextField = false;
  List<String> paymentOption = ['yes', 'no'];
  String? selectedOption;
  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL'];
  List<String> selectedCategories = [];
  List<String> selectedSubCategories = [];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    var sizedBox = SizedBox(height: 12.h);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomeTextfieldWidget(
          controller: widget.titleController,
          isRTL: widget.isArabic,
          formFieldValidator: (value) =>
              Validators.requiredField(context, value),
          labelText: loc.productTitle,
        ),
        sizedBox,
        TextFieldForInstructions(
          title: loc.shortDescription,
          hintText: loc.enterProductDescriptionForQuickView,
          textEditingController: widget.shortDescriptionController,
          formFieldValidator: (value) =>
              Validators.requiredField(context, value),
        ),
        sizedBox,
        CustomeTextfieldWidget(
          controller: widget.tagController,
          isRTL: widget.isArabic,
          labelText: loc.tags,
          formFieldValidator: (value) =>
              Validators.requiredField(context, value),
        ),
        sizedBox,
        CustomeTextfieldWidget(
          controller: widget.warranty,
          isRTL: widget.isArabic,
          labelText: loc.warranty,
        ),
        sizedBox,
        CustomeTextfieldWidget(
          controller: widget.brandController,
          isRTL: widget.isArabic,
          labelText: loc.brand,
          formFieldValidator: (value) =>
              Validators.requiredField(context, value),
        ),
        sizedBox,
        Text(loc.colors, style: Theme.of(context).textTheme.headlineMedium),
        sizedBox,
        Wrap(
          spacing: 10,
          children: colorOptions.entries.map((entry) {
            final hex = entry.key;
            final color = entry.value;
            final isSelected = selectedColors.contains(hex);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedColors.remove(hex);
                  } else {
                    selectedColors.add(hex);
                  }
                });
                widget.onColorsSelected?.call(selectedColors);
              },
              child: Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? (isDark ? Colors.white : Colors.black)
                        : Colors.black12,
                    width: isSelected ? 2 : 1,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (selectedColors.isEmpty) ...[
          sizedBox,
          Text(
            loc.pleaseSelectAtLeastOneColor,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
        sizedBox,
        Text(
          loc.customeSpecifications,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        sizedBox,
        TextButton(
          onPressed: () {
            setState(() {
              showTextField = !showTextField;
            });
          },
          child: Row(
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: lightTheme.colorScheme.primary,
              ),
              SizedBox(width: 10.w),
              Text(
                loc.addSpecification,
                style: TextStyle(color: lightTheme.colorScheme.primary),
              ),
            ],
          ),
        ),
        sizedBox,
        if (showTextField)
          CustomeTextfieldWidget(
            controller: widget.customPropertiesController,
            isRTL: widget.isArabic,
            labelText: loc.customeSpecifications,
          ),
        sizedBox,
        CustomeTextfieldWidget(
          controller: widget.slugController,
          isRTL: widget.isArabic,
          labelText: loc.slug,
          formFieldValidator: (value) =>
              Validators.requiredField(context, value),
        ),
        sizedBox,
        Text(
          loc.cashOnDelivery,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        sizedBox,
        DropdownButtonFormField<String?>(
          value: selectedOption,
          icon: const Icon(Icons.keyboard_arrow_down),
          decoration: InputDecoration(
            labelText: loc.selectAnOption,
            border: const OutlineInputBorder(),
          ),
          validator: (value) => value == null ? loc.fieldRequired : null,
          items: paymentOption.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item == 'yes' ? loc.yes : loc.no,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedOption = value;
              widget.paymentOptionController.text = value!;
            });
          },
        ),
        sizedBox,
        CategorySelectionWidget(
          onSelectionChanged: (categories, subcategories) {
            setState(() {
              selectedCategories = categories;
              selectedSubCategories = subcategories;
            });
            widget.onCategorySelected?.call(categories, subcategories);
          },
        ),
        sizedBox,
        TextFieldForInstructions(
          title: loc.detailedDescription,
          hintText: loc.writeADetailedDescriptionHere,
          textEditingController: widget.detailedDescriptionController,
          formFieldValidator: (value) =>
              Validators.requiredField(context, value),
        ),
        sizedBox,
        CustomeTextfieldWidget(
          controller: widget.videoURLController,
          isRTL: widget.isArabic,
          labelText: loc.videoURL,
        ),
        sizedBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: CustomeTextfieldWidget(
                controller: widget.regularPriceController,
                isRTL: widget.isArabic,
                labelText: loc.regularPrice,
                textInputType: TextInputType.number,
                formFieldValidator: (value) =>
                    Validators.requiredField(context, value),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomeTextfieldWidget(
                controller: widget.salePriceController,
                isRTL: widget.isArabic,
                labelText: loc.salePrice,
                textInputType: TextInputType.number,
                formFieldValidator: (value) {
                  return Validators.requiredField(context, value);
                },
              ),
            ),
          ],
        ),
        sizedBox,
        CustomeTextfieldWidget(
          controller: widget.stockController,
          isRTL: widget.isArabic,
          labelText: loc.stock,
          textInputType: TextInputType.number,
          formFieldValidator: (value) =>
              Validators.requiredField(context, value),
        ),
        sizedBox,
        Text(loc.sizes, style: Theme.of(context).textTheme.headlineMedium),
        sizedBox,
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: sizes.map((size) {
              final isSelected = selectedSizes.contains(size);
              return FilterChip(
                label: Text(size),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedSizes.add(size);
                    } else {
                      selectedSizes.remove(size);
                    }
                  });
                  widget.onSizesSelected?.call(selectedSizes);
                },
              );
            }).toList(),
          ),
        ),
        if (selectedSizes.isEmpty) ...[
          sizedBox,
          Text(
            loc.pleaseSelectAtLeastOneSize,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ],
    );
  }
}
