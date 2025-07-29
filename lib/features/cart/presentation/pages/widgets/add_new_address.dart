import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

class AddNewAddressWidget extends StatelessWidget {
  final String title;
  const AddNewAddressWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(color: Theme.of(context).colorScheme.background),
      ),
      child: InkWell(
        onTap: () {
          //TODO:: make the logic of the add new address for user
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
