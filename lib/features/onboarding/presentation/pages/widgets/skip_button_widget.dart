import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class SkipButtonWidget extends StatefulWidget {
  const SkipButtonWidget({super.key});

  @override
  State<SkipButtonWidget> createState() => _SkipButtonWidgetState();
}

class _SkipButtonWidgetState extends State<SkipButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/loginScreen');
      },
      child: Container(alignment: Alignment.centerRight, child: Text(loc.skip)),
    );
  }
}
