import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

class OtpTextfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const OtpTextfieldWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 20),
        onChanged: onChanged,
        decoration: InputDecoration(
          counterText: '',
          border: Theme.of(context).inputDecorationTheme.border,
        ),
      ),
    );
  }
}
