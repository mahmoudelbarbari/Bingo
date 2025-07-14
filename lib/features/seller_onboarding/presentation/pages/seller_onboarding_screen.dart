import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/features/seller_onboarding/presentation/pages/file_upload_screen.dart';
import 'package:bingo/features/seller_onboarding/presentation/pages/widgets/welcome_seller_onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection_container.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/file_upload_cubit.dart';

class SellerOnboardingScreen extends StatelessWidget {
  const SellerOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WelcomeSellerOnboardingWidget(),
            SizedBox(height: 24.h),
            ElevatedButtonWidget(
              fun: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => FileUploadCubit(sl()),
                      child: const FileUploadSection(),
                    ),
                  ),
                );
              },
              text: loc.verifyNow,
              isColored: true,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                loc.needHelpContactSupport,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              loc.thisInfoIsUsedForIdentityVerficationOnlyAndWillBeKeptSecureByBingo,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
