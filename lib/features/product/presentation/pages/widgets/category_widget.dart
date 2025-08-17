import 'package:bingo/features/home/presentaion/cubit/home_state.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../../../home/data/models/category_model.dart.dart';
import '../../../../home/presentaion/cubit/home_cubit.dart';

typedef CategorySelectionCallback =
    void Function(List<String> categories, List<String> subcategories);

class CategorySelectionWidget extends StatefulWidget {
  final CategorySelectionCallback? onSelectionChanged;

  const CategorySelectionWidget({super.key, this.onSelectionChanged});

  @override
  _CategorySelectionWidgetState createState() =>
      _CategorySelectionWidgetState();
}

class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {
  List<String> selectedCategories = [];
  List<String> selectedSubCategories = [];

  @override
  void initState() {
    super.initState();
    // Fetch categories from Cubit
    context.read<HomeCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is CategoriesLoaded) {
          final CategoryModel model = state.categories;

          final List<MultiSelectItem<String>> categoryItems = model.categories
              .map((cat) => MultiSelectItem<String>(cat, cat))
              .toList();

          // Collect subcategories only for selected categories
          final List<String> allSubcategories = selectedCategories
              .expand((cat) => (model.subCategories[cat] ?? []).cast<String>())
              .toSet()
              .toList();

          final List<MultiSelectItem<String>> subCategoryItems =
              allSubcategories
                  .map((sub) => MultiSelectItem<String>(sub, sub))
                  .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(loc.selectCategories),
              MultiSelectDialogField<String>(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                items: categoryItems,
                initialValue: selectedCategories,
                title: Text(loc.categories),
                buttonText: Text(loc.selectCategories),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  setState(() {
                    selectedCategories = values;
                    selectedSubCategories = [];
                  });
                  widget.onSelectionChanged?.call(
                    selectedCategories,
                    selectedSubCategories,
                  );
                },
              ),
              const SizedBox(height: 20),
              if (selectedCategories.isNotEmpty) ...[
                Text(loc.selectSubcategories),
                MultiSelectDialogField<String>(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  items: subCategoryItems,
                  initialValue: selectedSubCategories,
                  title: Text(loc.subCategories),
                  buttonText: Text(loc.selectSubcategories),
                  listType: MultiSelectListType.CHIP,
                  onConfirm: (values) {
                    setState(() {
                      selectedSubCategories = values;
                    });
                    widget.onSelectionChanged?.call(
                      selectedCategories,
                      selectedSubCategories,
                    );
                  },
                ),
              ],
            ],
          );
        } else if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Text(loc.failedToLoadCategories);
        }
      },
    );
  }
}
