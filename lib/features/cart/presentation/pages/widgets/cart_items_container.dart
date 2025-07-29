import 'package:bingo/config/theme_app.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/counter_button_widget.dart';
import 'package:bingo/l10n/app_localizations.dart';

import 'package:flutter/material.dart';

class CartItemsContainer extends StatefulWidget {
  final Center center;
  final String image;
  final String title;
  final String desc;
  final double? proPrice;
  final String? proId;

  final Function(int, double) onPriceUpdate; // Add callback

  const CartItemsContainer({
    super.key,
    required this.center,
    required this.image,
    required this.title,
    required this.proPrice,
    required this.desc,
    required this.onPriceUpdate, // Add to constructor
    this.proId,
  });

  @override
  State<CartItemsContainer> createState() => _CartItemsContainerState();
}

class _CartItemsContainerState extends State<CartItemsContainer>
    with AutomaticKeepAliveClientMixin {
  int count = 1;
  double delivartFee = 25.0;
  double serviceFee = 12.0;

  @override
  bool get wantKeepAlive => true;

  double get totalPrice => widget.proPrice! * count + delivartFee + serviceFee;

  void _updateCount(int newCount) {
    setState(() {
      count = newCount;
    });
    widget.onPriceUpdate(count, totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            widget.center,
            ListTile(
              leading: SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(widget.image, fit: BoxFit.cover),
                ),
              ),
              title: Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.desc,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${loc.egp} : ${widget.proPrice! * count}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      CounterButton(
                        count: count,
                        plusIconColor: lightTheme.colorScheme.primary,
                        minusIconColor: isDark
                            ? Colors.white10
                            : Colors.black12,
                        onChange: _updateCount,
                        proId: widget.proId,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
