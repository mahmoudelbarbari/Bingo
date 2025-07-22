import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

class ActionBtnTopBarWidget extends StatelessWidget {
  final String icon;
  final void Function()? onTap;

  const ActionBtnTopBarWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? null : Colors.white,
        boxShadow: [
          ?isDark
              ? null
              : BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
        ],
      ),
      child: InkWell(onTap: onTap, child: ImageIcon(AssetImage(icon))),
    );
  }
}
