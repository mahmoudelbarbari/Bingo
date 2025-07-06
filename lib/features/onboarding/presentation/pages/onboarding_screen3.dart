import 'package:bingo/features/onboarding/presentation/pages/widgets/onboarding_welcome_text_widget.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/dot_progress_bar_widget.dart';
import '../../../../core/widgets/progress_button.dart';

class OnboardingScreen3 extends StatefulWidget {
  final int step;

  const OnboardingScreen3({super.key, required this.step});

  @override
  State<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3> {
  @override
  Widget build(BuildContext context) {
    double progress = (widget.step + 1) / 100;
    const sizeBox = SizedBox(height: 30);
    return Scaffold(
      body: Column(
        children: [
          sizeBox,
          sizeBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 120,
            children: [
              Image.asset(Assets.images.onboadring9.path),
              Image.asset(Assets.images.onboadring10.path),
            ],
          ),
          sizeBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Image.asset(Assets.images.onboadring11.path),
              ),
              Image.asset(Assets.images.onboadring12.path),
            ],
          ),
          sizeBox,
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: OnboardingWelcomeTextWidget(
              headerText1: 'Buy \t',
              headerText2: 'handmade Treasures',
              desc1: 'Own unique handmade pieces crafted with love,',
              desc2: 'authenticity, and passion.',
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DotProgressBar(totalDots: 3, currentDot: widget.step),
                  ProgressButton(
                    progress: progress,
                    onPressed: () {
                      if (widget.step < 2) {
                        Navigator.pushReplacementNamed(context, '/onboarding3');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Final step reached!")),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
