import 'package:flutter/material.dart';

class PaymentSummaryWidget extends StatelessWidget {
  final String startName;
  final String endName;

  const PaymentSummaryWidget({
    required this.startName,
    required this.endName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(startName, style: const TextStyle(fontSize: 15)),
        Text(endName, style: const TextStyle(fontSize: 15)),
      ],
    );
  }
}
