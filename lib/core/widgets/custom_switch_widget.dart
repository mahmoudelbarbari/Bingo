import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;
  final bool enabled;

  const SwitchWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: enabled ? null : Colors.grey,
            ),
          ),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
