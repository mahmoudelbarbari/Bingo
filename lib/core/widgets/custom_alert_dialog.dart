import 'package:flutter/material.dart';

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
    final imageAsset = isSuccess
        ? 'assets/images/success.png'
        : 'assets/images/error.png';

    final titleText = isSuccess ? 'Success' : 'Error';

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Image.asset(imageAsset, width: 40, height: 40),
          const SizedBox(width: 10),
          Text(
            titleText,
            style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
          ),
        ],
      ),
      content: Text(message, style: const TextStyle(fontSize: 16)),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
