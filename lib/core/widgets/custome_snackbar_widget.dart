import 'package:flutter/material.dart';

import '../../config/custome_snackbar_color.dart';

void showAppSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
  IconData? icon,
}) {
  final snackBarColors = Theme.of(context).extension<SnackBarColors>()!;
  final color = isError ? snackBarColors.error : snackBarColors.success;

  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          icon ?? (isError ? Icons.error : Icons.check_circle),
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(message, style: const TextStyle(color: Colors.white)),
        ),
      ],
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
