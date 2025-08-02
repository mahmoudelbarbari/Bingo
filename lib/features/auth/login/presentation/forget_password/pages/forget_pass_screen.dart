import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/util/validators.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/core/widgets/custome_textfield_widget.dart';
import 'package:bingo/core/widgets/welcome_header_widget.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/dismiss_keyboared_scroll_view.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../cubit/forget_pass_cubit.dart';
import '../cubit/forget_pass_state.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  late TextEditingController controllerEmail;
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    controllerEmail = TextEditingController();
    controllerEmail.addListener(_validateForm);
  }

  void _validateForm() {
    final emailFilled = controllerEmail.text.trim().isNotEmpty;

    setState(() {
      isButtonEnabled = emailFilled;
    });
  }

  @override
  void dispose() {
    controllerEmail.removeListener(_validateForm);
    controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body: BlocProvider(
          create: (context) => ForgotPasswordCubit(),
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state is ForgotPasswordError) {
                // showDialog(
                //   context: context,
                //   builder: (context) => CustomAlertDialog(
                //     message: state.message,
                //     isSuccess: false,
                //   ),
                // );
                Navigator.pushNamed(
                  context,
                  '/otpVerify',
                  arguments: controllerEmail.text.trim(),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _keyform,
                child: DismissKeyboardScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 15.w,
                    ),
                    child: Column(
                      children: [
                        WelcomeHeaderWidget(
                          imageURL: Assets.images.bingoLogo1.path,
                          headerText1: loc.forgotPassword,
                          headerSubText: loc.dontWorryWellHelpYouResetIt,
                        ),
                        SizedBox(height: 24.h),
                        CustomeTextfieldWidget(
                          controller: controllerEmail,
                          labelText: loc.yourEmail,
                          prefixIcon: Icon(Icons.email),
                          isRTL: isArabic,
                          formFieldValidator: (value) {
                            return Validators.email(context, value);
                          },
                        ),
                        SizedBox(height: 24.h),
                        ElevatedButtonWidget(
                          fun: () {
                            if (_keyform.currentState!.validate()) {
                              context.read<ForgotPasswordCubit>().sendOtp(
                                controllerEmail.text.trim(),
                              );
                            }
                          },
                          text: loc.send,
                          isColored: isButtonEnabled,
                          isEnabled: isButtonEnabled,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
