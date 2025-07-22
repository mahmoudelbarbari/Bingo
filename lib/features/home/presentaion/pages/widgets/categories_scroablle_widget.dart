import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/home/presentaion/pages/categories_screen.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/category_item.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/categoriy_entity.dart';

class CategoriesScroablleWidget extends StatefulWidget {
  const CategoriesScroablleWidget({super.key});

  @override
  State<CategoriesScroablleWidget> createState() =>
      _CategoriesScroablleWidgetState();
}

class _CategoriesScroablleWidgetState extends State<CategoriesScroablleWidget> {
  @override
  Widget build(BuildContext context) {
    final firstFive = categoryList.take(5).toList();

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
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: firstFive.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CategoryItem(category: firstFive[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
