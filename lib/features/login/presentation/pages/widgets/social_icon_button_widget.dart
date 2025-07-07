import 'package:flutter/material.dart';

import '../../../../../core/util/size_config.dart';

class SocialIconButton extends StatelessWidget {
  final Widget icon;
  final Color bgColor;
  final VoidCallback onPressed;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.bgColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: IconButton(onPressed: onPressed, icon: icon),
      ),
    );
  }
}
