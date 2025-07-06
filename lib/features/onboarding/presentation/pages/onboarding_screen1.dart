import 'package:bingo/features/onboarding/presentation/pages/widgets/onboarding_welcome_text_widget.dart';
import 'package:bingo/features/onboarding/presentation/pages/widgets/skip_button_widget.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/dot_progress_bar_widget.dart';
import '../../../../core/widgets/progress_button.dart';

class OnboardingScreen1 extends StatefulWidget {
  final int step;
  const OnboardingScreen1({super.key, required this.step});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  int dotedProgress = 0;

  @override
  void initState() {
    super.initState();
    dotedProgress = widget.step;
  }

  @override
  Widget build(BuildContext context) {
    double progress = (widget.step + 1) / 1.50;
    const sizeBox = SizedBox(height: 30);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            sizeBox,
            SkipButtonWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Image.asset(Assets.images.onboarding1.path),
                ),
                Image.asset(Assets.images.onboadring2.path),
              ],
            ),
            sizeBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Image.asset(Assets.images.onboadring3.path),
                ),
                Image.asset(Assets.images.onboadring4.path),
              ],
            ),
            sizeBox,
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: OnboardingWelcomeTextWidget(
                headerText1: 'Handmade \t',
                headerText2: 'with Love',
                desc1: 'Discover talented makers creating unique',
                desc2: 'handmade treasures!',
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
                          Navigator.pushReplacementNamed(
                            context,
                            '/onboarding2',
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Final step reached!"),
                            ),
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
      ),
    );
  }
}
