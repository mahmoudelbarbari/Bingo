import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../l10n/app_localizations.dart';

class CreditCardLayoutWidget extends StatelessWidget {
  const CreditCardLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final sizedBox = SizedBox(height: 24.h);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 41, 93, 110),
            Color.fromARGB(255, 22, 46, 55),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(Assets.images.visaNetwork.path),
                Text(
                  loc.visa,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: FontFamily.sFProDisplay,
                  ),
                ),
              ],
            ),
          ),
          sizedBox,
          Text(
            '3455 4562 7710 3507',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: FontFamily.sFProDisplay,
            ),
          ),
          sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(loc.cardHolderName),
                  Text(
                    'Mariam Radhad',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(loc.expiryDate),
                  Text(
                    '05/30',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Image.asset(Assets.images.chip.path),
            ],
          ),
        ],
      ),
    );
  }
}
