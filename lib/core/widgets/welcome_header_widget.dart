import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  final String imageURL;
  final String headerText1;
  final String? headerText2;
  final String headerSubText;
  final IconData? icon;
  const WelcomeHeaderWidget({
    super.key,
    required this.imageURL,
    required this.headerText1,
    this.headerText2,
    required this.headerSubText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        Image.asset(imageURL, width: 200.w, height: 200.h),
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
            text: headerText1,
            style: Theme.of(context).textTheme.titleLarge,
            children: [
              TextSpan(
                text: headerText2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              WidgetSpan(child: Icon(icon, size: 24)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(headerSubText, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
