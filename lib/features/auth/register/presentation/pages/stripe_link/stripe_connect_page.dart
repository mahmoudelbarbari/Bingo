import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/core/widgets/loading_widget.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/register_model.dart';
import '../../cubit/register_cubit.dart';
import '../../cubit/register_state.dart';

class StripeConnectPage extends StatefulWidget {
  final SellerAccountModel sellerAccountModel;

  const StripeConnectPage({Key? key, required this.sellerAccountModel})
    : super(key: key);

  @override
  State<StripeConnectPage> createState() => _StripeConnectPageState();
}

class _StripeConnectPageState extends State<StripeConnectPage> {
  @override
  void initState() {
    super.initState();
    // You can add any initialization logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.setupPaymentAccount),
        automaticallyImplyLeading: false, // Disable back button
      ),
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is StripeConnectSuccessState) {
            print('🔗 Success state received with URL: ${state.url}');

            // Check if URL is valid and launch it
            if (state.url.isNotEmpty && state.url.startsWith('https://')) {
              print('�� Valid URL detected, launching...');
              _launchStripeConnectUrl(state.url);
              // Show success dialog after a short delay
              Future.delayed(Duration(milliseconds: 500), () {
                _showSuccessDialog();
              });
            } else {
              print('🔗 Invalid URL: ${state.url}');
              showAppSnackBar(
                context,
                'Invalid URL received: ${state.url}',
                isError: true,
              );
            }
          } else if (state is StripeConnectErrorState) {
            showAppSnackBar(context, state.errorMessage, isError: true);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                width: 15.w,
                height: 15.h,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  size: 30,
                  color: Colors.green,
                ),
              ),

              SizedBox(height: 14.h),

              // Success Message
              Text(
                loc.shopCreatedSuccessfully,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 12.h),

              Text(
                loc.yourShopHasVeenCreatedSuccessfullyNowYouNeedToSetUpYourPaymentAccountToStartReceivingPayments,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 14.h),

              // Stripe Connect Button
              BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 100.h,
                    child: ElevatedButton(
                      onPressed: state is StripeConnectLoadingState
                          ? null
                          : () => _generateStripeConnectLink(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state is StripeConnectLoadingState
                          ? LoadingWidget()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.payment, size: 30),
                                SizedBox(width: 10.w),
                                Text(
                                  loc.setupPaymentAccount,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),

              SizedBox(height: 14.h),

              // Skip for now button (optional)
              TextButton(
                onPressed: () => _navigateToLogin(),
                child: Text(
                  loc.skipForNow,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _generateStripeConnectLink() {
    final loc = AppLocalizations.of(context)!;
    if (widget.sellerAccountModel.id != null) {
      context.read<RegisterCubit>().createStripeConnectLink(
        widget.sellerAccountModel.id!,
      );
    } else {
      showAppSnackBar(
        context,
        loc.sellerIdNotFoundPleaseTryAgain,
        isError: true,
      );
    }
  }

  // Update the _launchStripeConnectUrl method
  void _launchStripeConnectUrl(String url) async {
    try {
      // Validate URL format
      if (!url.startsWith('https://')) {
        throw 'Invalid URL format: $url';
      }
      final Uri uri = Uri.parse(url);

      // Try to launch the URL directly
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (launched) {
      } else {
        _showUrlDialog(url);
      }
    } catch (e) {
      _showUrlDialog(url);
    }
  }

  // Update the _showUrlDialog method to be more user-friendly
  void _showUrlDialog(String url) {
    final loc = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(loc.paymentSetupInitiated),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${loc.yourPaymentAccountSetupHasBeenInitiatedPleaseCompleteTheSetupProcessInTheBrowserThatJustOpenedYouWillBeRedirectedToTheLoginPage}\n\n',
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: SelectableText(
                  url,
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ),
              SizedBox(height: 16),
              Text(
                loc.completeThePaymentSetupInYourBrowserThenReturnToTheApp,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToLogin();
              },
              child: Text(loc.continueToLogin),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    final loc = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(loc.paymentSetupInitiated),
          content: Text(
            loc.yourPaymentAccountSetupHasBeenInitiatedPleaseCompleteTheSetupProcessInTheBrowserThatJustOpenedYouWillBeRedirectedToTheLoginPage,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToLogin();
              },
              child: Text(loc.continueToLogin),
            ),
          ],
        );
      },
    );
  }

  void _navigateToLogin() {
    // Navigate to login page and clear the navigation stack
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/loginScreen', // Replace with your actual login route
      (Route<dynamic> route) => false,
    );
  }
}
