import 'package:flutter/material.dart';

class SkipButtonWidget extends StatefulWidget {
  const SkipButtonWidget({super.key});

  @override
  State<SkipButtonWidget> createState() => _SkipButtonWidgetState();
}

class _SkipButtonWidgetState extends State<SkipButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(alignment: Alignment.centerRight, child: Text('Skip')),
    );
  }
}
