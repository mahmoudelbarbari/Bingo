import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class ShopNameInstruction extends StatelessWidget {
  const ShopNameInstruction({
    super.key,
    required this.loc,
    required this.sizedBox,
  });

  final AppLocalizations loc;
  final SizedBox sizedBox;
  @override
  Widget build(BuildContext context) {
    var bodySmall2 = Theme.of(context).textTheme.bodySmall;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('• ${loc.between420Characters}', style: bodySmall2),
        sizedBox,
        Text('• ${loc.noSpercialCharactersSpaces}', style: bodySmall2),
        sizedBox,
        Text('• ${loc.chooseAUniqueName}', style: bodySmall2),
      ],
    );
  }
}
