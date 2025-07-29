import 'package:bingo/config/theme_app.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int>? onChanged;
  final Color? buttonColor;
  final Color? textColor;
  final double size;
  final TextStyle? textStyle;

  const CounterWidget({
    Key? key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = 100,
    this.onChanged,
    this.buttonColor,
    this.textColor,
    this.size = 16,
    this.textStyle,
  }) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue.clamp(widget.minValue, widget.maxValue);
  }

  void _increment() {
    if (_count < widget.maxValue) {
      setState(() => _count++);
      widget.onChanged?.call(_count);
    }
  }

  void _decrement() {
    if (_count > widget.minValue) {
      setState(() => _count--);
      widget.onChanged?.call(_count);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(Icons.remove, _decrement),
        SizedBox(width: 12),
        Text(
          '$_count',
          style:
              widget.textStyle ??
              TextStyle(
                fontSize: widget.size,
                color:
                    widget.textColor ??
                    Theme.of(context).textTheme.bodyLarge?.color,
              ),
        ),
        SizedBox(width: 12),
        _buildButton(Icons.add, _increment),
      ],
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(3),
          ),
          backgroundColor: widget.buttonColor ?? Theme.of(context).primaryColor,
        ),
        onPressed: onPressed,
        child: Icon(
          icon,
          size: widget.size * 0.5,
          color: isDark ? Colors.white : lightTheme.colorScheme.primary,
        ),
      ),
    );
  }
}
