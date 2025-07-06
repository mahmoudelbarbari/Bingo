import 'package:flutter/material.dart';

class OnboardingWelcomeTextWidget extends StatelessWidget {
  final String headerText1;
  final String headerText2;
  final String desc1;
  final String desc2;
  const OnboardingWelcomeTextWidget({
    super.key,
    required this.headerText1,
    required this.headerText2,
    required this.desc1,
    required this.desc2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: headerText1,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            children: [
              TextSpan(
                text: headerText2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Text(desc1, style: Theme.of(context).textTheme.bodySmall),
        ),
        Center(
          child: Text(desc2, style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}
