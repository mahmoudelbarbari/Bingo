import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_outlined_btn_widget.dart';
import 'package:bingo/features/cart/presentation/pages/address_screen.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/payment_summary_widget.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class BottomContainerCartWidget extends StatelessWidget {
  final double total;
  final int productModel;
  const BottomContainerCartWidget({
    super.key,
    required this.total,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    double delivartFee = 25.0;
    double serviceFee = 12.0;

    final loc = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: isDark ? null : Colors.white,
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
            child: PaymentSummaryWidget(
              startName: loc.delivery,
              endName: delivartFee.toString(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 7.h),
            child: PaymentSummaryWidget(
              startName: loc.service,
              endName: serviceFee.toString(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${loc.total} ${loc.price}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '$total :${loc.egp}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
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
                    // showAlertDialog(context, isCloseDismissible: true);
                    // context.read<CartCubit>().clearCartItems();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddressScreen(
                          totalCartPrice: total,
                          productModel: productModel,
                        ),
                      ),
                    );
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
