import 'package:bingo/config/theme_app.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/counter_button_widget.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/payment_summary_widget.dart';
import 'package:bingo/l10n/app_localizations.dart';

import 'package:flutter/material.dart';

class CartItemsContainer extends StatefulWidget {
  final Center center;
  final String title;
  final double? subTitle;

  const CartItemsContainer({
    super.key,
    required this.center,
    required this.title,
    required this.subTitle,
  });

  @override
  State<CartItemsContainer> createState() => _CartItemsContainerState();
}

class _CartItemsContainerState extends State<CartItemsContainer> {
  int count = 1;
  double delivartFee = 25.0;
  double serviceFee = 12.0;
  double totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          widget.center,
          ListTile(
            title: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'dqwdqwdqwdqw',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${loc.egp} : ${widget.subTitle! * count}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    // CounterButton(
                    //   buttonColor: lightTheme.colorScheme.primary,
                    //   count: count,
                    //   onChange: (value) {
                    //     setState(() {
                    //       count = value;
                    //       if (count < 1) {
                    //         count++;
                    //       }
                    //     });
                    //   },
                    //   loading: false,
                    // ),
                    CounterButton(
                      count: count,
                      plusIconColor: lightTheme.colorScheme.primary,
                      minusIconColor: lightTheme.colorScheme.primary,
                      onChange: (value) {
                        setState(() {
                          count = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          widget.center,
          PaymentSummaryWidget(
            startName: loc.delivery,
            endName: delivartFee.toString(),
          ),
          PaymentSummaryWidget(
            startName: loc.service,
            endName: serviceFee.toString(),
          ),
          PaymentSummaryWidget(
            startName: loc.total,
            endName:
                "${loc.egp} : ${widget.subTitle! * count + delivartFee + serviceFee}",
          ),
        ],
      ),
    );
  }
}
