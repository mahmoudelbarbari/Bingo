import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/loading_widget.dart';
import 'package:bingo/features/home/presentaion/cubit/home_cubit.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/category_item.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/category_vertical_item_widget.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/view_switch_widget.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_state.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isGrid = true;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.categories,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) {
          return current is CategoriesLoading ||
              current is CategoriesLoaded ||
              current is CategoriesError;
        },
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const LoadingWidget();
          } else if (state is CategoriesLoaded) {
            final categories = state.categories.categories;
            final subCategories = state.categories.subCategories;

            final allItems = [
              ...categories.map((cat) => _CategoryItemData(cat, false)),
              ...subCategories.entries.expand(
                (entry) =>
                    entry.value.map((sub) => _CategoryItemData(sub, true)),
              ),
            ];
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.categories,
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: ' (${allItems.length})',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ViewSwitcherWidget(
                        isGridView: isGrid,
                        onGridTap: () => setState(() => isGrid = true),
                        onListTap: () => setState(() => isGrid = false),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: isGrid
                      ? GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.9,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemCount: allItems.length,
                          itemBuilder: (context, index) => CategoryItem(
                            title: allItems[index].title,
                            isSubcategory: allItems[index].isSubcategory,
                          ),
                        )
                      : ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final subcategories = subCategories[category] ?? [];
                            return CategoryVerticalItemWidget(
                              category: category,
                              subcategories: subcategories,
                            );
                          },
                        ),
                ),
              ],
            );
          } else if (state is CategoriesError) {
            return Center(child: Text(state.message));
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}

class _CategoryItemData {
  final String title;
  final bool isSubcategory;

  _CategoryItemData(this.title, this.isSubcategory);
}
