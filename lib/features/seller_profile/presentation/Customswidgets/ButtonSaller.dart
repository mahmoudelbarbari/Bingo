import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ButtonSeller extends StatelessWidget {
  const ButtonSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Contact Seller Button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset(
                Assets.images.messageChatCircle.path,
                width: 20.w,
                height: 20.h,
              ),
              label: Text(
                'Contact Seller',
                style: TextStyle(
                  color: lightTheme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFF1F3),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: lightTheme.colorScheme.primary),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // See My Creations Button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset(
                Assets.images.heartHand1.path,
                width: 20.w,
                height: 20.h,
              ),
              label: const Text(
                'See My Creations',
                style: TextStyle(
                  color: Color(0xFF00629B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE7F3FA),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF00629B)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
