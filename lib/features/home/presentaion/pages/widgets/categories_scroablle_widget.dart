import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/loading_widget.dart';
import 'package:bingo/features/home/presentaion/cubit/home_cubit.dart';
import 'package:bingo/features/home/presentaion/pages/categories_screen.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/category_item.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_state.dart';

class CategoriesScroablleWidget extends StatefulWidget {
  const CategoriesScroablleWidget({super.key});

  @override
  State<CategoriesScroablleWidget> createState() =>
      _CategoriesScroablleWidgetState();
}

class _CategoriesScroablleWidgetState extends State<CategoriesScroablleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.categories,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.viewAll,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              current is CategoriesLoading ||
              current is CategoriesLoaded ||
              current is CategoriesError,
          builder: (context, state) {
            // Prefer current state if available
            if (state is CategoriesLoading) {
              // If we have cached categories, show them instead of a loader
              final cached = context.read<HomeCubit>().cachedCategories;
              if (cached != null) {
                final firstFive = cached.categories.take(5).toList();
                return _buildCategoriesList(firstFive);
              }
              return const LoadingWidget();
            } else if (state is CategoriesLoaded) {
              final firstFive = state.categories.categories.take(5).toList();
              return _buildCategoriesList(firstFive);
            } else if (state is CategoriesError) {
              // Fallback to cached categories on error
              final cached = context.read<HomeCubit>().cachedCategories;
              if (cached != null) {
                final firstFive = cached.categories.take(5).toList();
                return _buildCategoriesList(firstFive);
              }
              return const SizedBox.shrink();
            }
            // For unrelated states, maintain previous UI (by not rebuilding)
            // but in case it rebuilds, fallback to cache if present
            final cached = context.read<HomeCubit>().cachedCategories;
            if (cached != null) {
              final firstFive = cached.categories.take(5).toList();
              return _buildCategoriesList(firstFive);
            }
            return const LoadingWidget();
          },
        ),
      ],
    );
  }

  Widget _buildCategoriesList(List<String> items) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CategoryItem(title: items[index]),
          );
        },
      ),
    );
  }
}
