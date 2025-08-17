import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../domain/entity/discount_code_entity.dart';

class DiscountCodeListItem extends StatelessWidget {
  final DiscountCodeEntity discountCode;
  final VoidCallback onDelete;

  const DiscountCodeListItem({
    super.key,
    required this.discountCode,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: ListTile(
        leading: _buildDiscountTypeIcon(),
        title: Text(discountCode.publicName ?? 'Unnamed Discount'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // Copy to clipboard
                Clipboard.setData(
                  ClipboardData(text: discountCode.discountCode ?? ''),
                );
                // Show a snackbar to confirm
                showAppSnackBar(context, loc.discountCodeCopiedToClipboard);
              },
              child: Row(
                children: [
                  Text(
                    'Code: ${discountCode.discountCode}',
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.copy, size: 16, color: Colors.blue),
                ],
              ),
            ),
            Text(
              '${loc.value}: ${discountCode.discountValue} ${discountCode.discountType == "Percentage" ? "%" : "EGP"}',
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }

  Widget _buildDiscountTypeIcon() {
    final isPercentage = discountCode.discountType == 'Percentage';

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: isPercentage
            ? Colors.green.withOpacity(0.2)
            : Colors.purple.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Icon(
          isPercentage ? Icons.percent : Icons.attach_money,
          color: isPercentage ? Colors.green : Colors.purple,
          size: 20.w,
        ),
      ),
    );
  }
}
