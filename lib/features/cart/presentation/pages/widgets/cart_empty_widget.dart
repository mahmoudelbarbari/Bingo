import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_outlined_btn_widget.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.images.cartEmptyImage.path),
          Text(loc.noProductYet, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 12.h),
          Text(
            loc.youHaventAddedAnyProductsYet,
            style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
          ),
          Text(
            loc.startExploringAndFindSomethingSpecial,
            style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
          ),
          SizedBox(height: 12.h),
          CustomeOutlinedBtnWidget(
            text: loc.startAdding,
            isSelected: true,
            onPressed: () => Navigator.pushNamed(context, '/bottomNavBar'),
          ),
        ],
      ),
    );
  }
}
