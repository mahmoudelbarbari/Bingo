import 'package:flutter/material.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  final String imageURL;
  final String headerText1;
  final String headerText2;
  final String headerSubText;
  final IconData icon;
  const WelcomeHeaderWidget({
    super.key,
    required this.imageURL,
    required this.headerText1,
    required this.headerText2,
    required this.headerSubText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Image.asset(imageURL),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: headerText1,
            style: TextStyle(fontSize: 24, color: Colors.black),
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
