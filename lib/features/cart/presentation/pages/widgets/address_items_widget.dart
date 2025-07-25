import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AddressItemsWidget extends StatelessWidget {
  final String address;
  final bool isSelected;
  final VoidCallback onSelect;

  const AddressItemsWidget({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? lightTheme.colorScheme.primary
              : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(Assets.images.location.path),
                color: isSelected
                    ? lightTheme.colorScheme.primary
                    : Theme.of(context).iconTheme.color,
              ),
              SizedBox(width: 7.w),
              // Address text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? lightTheme.colorScheme.primary
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Radio button
              Radio<bool>(
                value: true,
                groupValue: isSelected,
                onChanged: (value) => onSelect(),
                activeColor: lightTheme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
