import 'package:bingo/features/onboarding/presentation/pages/widgets/onboarding_welcome_text_widget.dart';
import 'package:bingo/features/onboarding/presentation/pages/widgets/skip_button_widget.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/dot_progress_bar_widget.dart';
import '../../../../core/widgets/progress_button.dart';
import '../../../../l10n/app_localizations.dart';

class OnboardingScreen2 extends StatefulWidget {
  final int step;

  const OnboardingScreen2({super.key, required this.step});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    double progress = (widget.step + 1) / 4.2;
    const sizeBox = SizedBox(height: 30);
    return Scaffold(
      body: Column(
        children: [
          sizeBox,
          SkipButtonWidget(),
          Row(
            spacing: 150,
            children: [
              Image.asset(Assets.images.onboadring5.path),
              Image.asset(Assets.images.onboadring7.path),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(Assets.images.onboadring8.path),
          ),
          Image.asset(Assets.images.onboadring6.path),
          sizeBox,
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: OnboardingWelcomeTextWidget(
              headerText1: '${loc.sell} \t',
              headerText2: loc.handmadeProducts,
              desc1: loc.showcaseYourSkillsConnectWithBuyersAnd,
              desc2: loc.turnPassionIntoBusiness,
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
                      Navigator.pushReplacementNamed(context, '/onboarding3');
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
