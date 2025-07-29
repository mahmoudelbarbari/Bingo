import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterButton extends StatelessWidget {
  final int count;
  final Color buttonColor;
  final Color plusIconColor;
  final Color minusIconColor;
  final bool loading;
  final ValueChanged<int> onChange;
  final double size;
  final double iconSize;
  final String? proId;

  const CounterButton({
    super.key,
    required this.count,
    required this.onChange,
    this.buttonColor = Colors.transparent,
    this.plusIconColor = Colors.white,
    this.minusIconColor = Colors.white,
    this.loading = false,
    this.size = 40.0,
    this.iconSize = 20.0,
    this.proId,
  });

  void _increment() {
    onChange(count + 1);
  }

  void _decrement(BuildContext context, String id) {
    if (count > 1) {
      onChange(count - 1);
    } else if (count == 1) {
      context.read<CartCubit>().deleteItemById(id);
      if (kDebugMode) {
        print('Attempting to delete item with ID: $id');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return loading
        ? SizedBox(
            height: size.h,
            width: size.w * 3,
            child: Center(child: CircularProgressIndicator()),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconButton(
                icon: (count == 1)
                    ? Icons.delete_forever_outlined
                    : Icons.remove,
                onPressed: () => _decrement(context, proId ?? ''),
                color: (count == 1)
                    ? minusIconColor
                    : lightTheme.colorScheme.primary,
                iconColor: isDark
                    ? (count == 1
                          ? (Colors.white60) // Dark theme, count = 1
                          : Colors.white) // Dark theme, count > 1
                    : (count == 1
                          ? Colors
                                .black38 // Light theme, count = 1
                          : Colors.white),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$count',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              _buildIconButton(
                icon: Icons.add,
                onPressed: _increment,
                color: plusIconColor,
                iconColor: Colors.white,
              ),
            ],
          );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
    required Color iconColor,
  }) {
    return IconButton(
      icon: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Icon(icon, size: iconSize, color: iconColor),
      ),
      onPressed: onPressed,
      splashRadius: size / 2,
    );
  }
}
