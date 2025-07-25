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
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Align(
      alignment: isRtl ? Alignment.bottomLeft : Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
        child: GestureDetector(
          onTap: onPressed,
          child: CustomPaint(
            painter: GradientCircleBorderPainter(),
            child: Container(
              height: 55.h,
              width: 50.w,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Center(child: Image.asset(iconAssetPath)),
            ),
          ),
        ),
      ),
    );
  }
}
