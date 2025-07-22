import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../../core/painters/gradient_circle_borde_painter.dart';

class ChatBotBtnWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconAssetPath;
  const ChatBotBtnWidget({
    super.key,
    required this.onPressed,
    required this.iconAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
        child: GestureDetector(
          onTap: onPressed,
          child: CustomPaint(
            painter: GradientCircleBorderPainter(),
            child: Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Center(child: Image.asset(iconAssetPath)),
            ),
          ),
        ),
      ),
    );
  }
}
