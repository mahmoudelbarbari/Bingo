import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.withOpacity(.7),
            thickness: 2,
            indent: 10,
          ),
        ),
        Text(
          "  ${loc.or}  ",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey.withOpacity(.7),
            thickness: 2,
            endIndent: 10,
          ),
        ),
      ],
    );
  }
}
