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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isSelected
            ? (isDark ? Color(0xFF3A1F1F) : Color(0xFFFDF5F5))
            : null,
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(
          color: isSelected
              ? Colors.transparent
              : Theme.of(context).colorScheme.background,
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
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        color: isSelected
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.onSurface,
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
