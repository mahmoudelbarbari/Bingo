import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_outlined_btn_widget.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cart_cubit.dart';
import 'cart_alert_dialog_widget.dart';

class BottomContainerCartWidget extends StatelessWidget {
  final double total;

  const BottomContainerCartWidget({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${loc.total} ${loc.price}'),
                Text('$total :${loc.egp}'),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomeOutlinedBtnWidget(
                  onPressed: () {
                    Navigator.pushNamed(context, '/bottomNavBar');
                  },
                  isSelected: false,
                  text: loc.addItem,
                ),
                CustomeOutlinedBtnWidget(
                  text: loc.checkout,
                  isSelected: true,
                  onPressed: () {
                    showAlertDialog(context, isCloseDismissible: true);
                    context.read<CartCubit>().clearCartItems();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
