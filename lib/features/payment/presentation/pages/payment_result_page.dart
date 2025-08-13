import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/dotted_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';

class PaymentResultPage extends StatelessWidget {
  final String totalPrice;
  final String paymentMethod;
  final String senderName;
  final String transactionId;

  const PaymentResultPage({
    super.key,
    required this.totalPrice,
    required this.paymentMethod,
    required this.senderName,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          loc.confirmOrder,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.green.shade100,
            radius: 30,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: Icon(Icons.check, size: 30),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            loc.paymentSuccessful,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 6.h),
          Text(
            loc.yourPaymentHasBeenSuccessfullyDone,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Card(
            margin: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24.0.h,
                horizontal: 24.0.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _infoRow(loc.amount, "$totalPrice ${loc.egp}"),
                  _statusRow(loc.paymentStatus, loc.success, Colors.green),
                  DottedLine(color: Colors.grey.shade400),
                  _infoRow(loc.orderNumber, transactionId),
                  _infoRow(loc.paymentMethod, paymentMethod),
                  _infoRow(loc.paymentDate, _formatDate(DateTime.now())),
                  _infoRow(loc.senderName, senderName),
                ],
              ),
            ),
          ),
          ElevatedButtonWidget(
            fun: () {
              Navigator.pushNamed(context, '/bottomNavBar');
            },
            text: loc.backToHome,
            isColored: true,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _statusRow(String label, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
