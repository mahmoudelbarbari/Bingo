import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

class AddNewAddressBtnWidget extends StatelessWidget {
  final String title;
  const AddNewAddressBtnWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(color: Theme.of(context).colorScheme.background),
      ),
      child: InkWell(
        onTap: () async {
          // Navigate to add address screen
          final result = await Navigator.pushNamed(
            context,
            '/addAddressScreen',
          );

          // Handle the result if needed
          if (result != null) {
            // TODO: Update the address list or refresh data
            // You can add your logic here to handle the new address
            print('New address added: $result');
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.add_circle_outline),
              SizedBox(width: 7.w),
              // Address text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
