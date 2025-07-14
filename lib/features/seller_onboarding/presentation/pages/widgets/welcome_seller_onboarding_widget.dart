import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class WelcomeSellerOnboardingWidget extends StatelessWidget {
  const WelcomeSellerOnboardingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      children: [
        Image.asset(Assets.images.sellerOnboardingWelcomeImage.path),
        SizedBox(height: 12.h),
        Text(
          loc.verifyYourAccountAndStartSelling,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        Text(
          loc.forASecureMarketPlaceWeRequireNationalIdentityVerfication,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
