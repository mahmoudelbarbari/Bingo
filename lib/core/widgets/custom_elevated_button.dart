import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';


class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback fun;
  final String text;
  final bool isColored;
  final bool isEnabled;
 const ElevatedButtonWidget({
    required this.fun,
    required this.text,
    required this.isColored,
    this.isEnabled = true,
  });
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(9),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          backgroundColor: isColored
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.withOpacity(.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: isEnabled ? fun : null,
        child: Text(text, style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}
