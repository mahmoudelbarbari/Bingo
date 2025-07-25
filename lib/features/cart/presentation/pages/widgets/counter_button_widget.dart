import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/cart/presentation/cubit/cart_cubit.dart';
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
      print('Attempting to delete item with ID: $id');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                icon: Icons.remove,
                onPressed: () => _decrement(context, proId ?? ''),
                color: minusIconColor,
              ),
              Container(
                alignment: Alignment.center,
                width: size,
                height: size,
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
              ),
            ],
          );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return IconButton(
      icon: Icon(icon, color: color, size: iconSize),
      onPressed: onPressed,
      splashRadius: size / 2,
    );
  }
}
