import 'package:flutter/material.dart';

import '../../../../../../core/util/size_config.dart';
import '../../../../../../gen/assets.gen.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Color(0xFFFBE9E7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(Assets.images.googleLogo.path, width: 20.w),
            ),
          ),
        ),
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(Assets.images.appleLogo.path),
            ),
          ),
        ),
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Color(0xFFE8F0FE),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(Assets.images.facebookLogo.path),
            ),
          ),
        ),
      ],
    );
  }
}
