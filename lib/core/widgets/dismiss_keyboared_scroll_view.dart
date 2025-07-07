import 'package:flutter/material.dart';

class DismissKeyboardScrollView extends StatelessWidget {
  final Widget child;

  const DismissKeyboardScrollView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(child: child),
        ),
      ),
    );
  }
}
