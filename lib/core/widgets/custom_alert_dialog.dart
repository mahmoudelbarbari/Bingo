import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../gen/assets.gen.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;
  final bool isSuccess;

  const CustomAlertDialog({
    super.key,
    required this.message,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final imageAsset = isSuccess
        ? 'assets/images/success.png'
        : Assets.images.noConnection.path;

    final titleText = isSuccess ? loc.success : loc.error;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        children: [
          Image.asset(imageAsset),
          const SizedBox(height: 10),
          Text(
            titleText,
            style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
          ),
        ],
      ),
      content: Text(message, style: const TextStyle(fontSize: 16)),
      actions: [
        TextButton(
          child: Text(loc.ok),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
