import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:bingo/features/auth/register/presentation/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/dismiss_keyboared_scroll_view.dart';
import '../../../../../core/widgets/welcome_header_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/app_localizations.dart';
import '../forget_password/cubit/forget_pass_cubit.dart';
import '../forget_password/cubit/forget_pass_state.dart';
import 'widgets/otp_textfield_widget.dart';

class OtpVerificationScreen extends StatefulWidget {
  final int otpLength;
  final String name;
  final String email;
  final String password;

  const OtpVerificationScreen({
    super.key,
    this.otpLength = 4,
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  bool isButtonEnabled = false;

  late String email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      email = args;
    }
  }

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.otpLength,
      (_) => TextEditingController(),
    );
    _focusNodes = List.generate(widget.otpLength, (_) => FocusNode());

    // Add listeners to update button state
    for (final controller in _controllers) {
      controller.addListener(_updateButtonState);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.removeListener(_updateButtonState);
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _updateButtonState() {
    final allFilled = _controllers.every(
      (controller) => controller.text.trim().isNotEmpty,
    );
    setState(() {
      isButtonEnabled = allFilled;
    });
  }

  void _onOtpFieldChanged(String value, int index) {
    if (value.length == 1 && index < widget.otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    _updateButtonState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is OtpVerificationSuccessState) {
          showAppSnackBar(context, "OTP verified successfully!");
          Navigator.pushNamed(context, '/bottomNavBar');
          // Navigate to next screen
        } else if (state is OtpVerificationErrorState) {
          showAppSnackBar(
            context,
            '${loc.error}: ${state.errorMessage}',
            isError: true,
          );
          // Navigator.pushNamed(context, '/createPassword', arguments: email);
        }
      },
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body: Form(
          key: _keyform,
          child: DismissKeyboardScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  WelcomeHeaderWidget(
                    imageURL: Assets.images.bingoLogo1.path,
                    headerText1: loc.verificationCode,
                    headerSubText: loc.pleaseEnterTheCodeThatWasSentToYourEmail,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.otpLength, (index) {
                      return OtpTextfieldWidget(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        onChanged: (value) => _onOtpFieldChanged(value, index),
                      );
                    }),
                  ),
                  SizedBox(height: 24.h),
                  BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                    builder: (context, state) {
                      return ElevatedButtonWidget(
                        text: loc.send,
                        fun: () {
                          final otpString = _controllers
                              .map((controller) => controller.text)
                              .join();
                          final otp = int.tryParse(otpString);
                          if (otp != null) {
                            context.read<RegisterCubit>().verifyOtpAndRegister(
                              name: widget.name,
                              email: widget.email,
                              password: widget.password,
                              otp: otp,
                            );
                          } else {
                            showAppSnackBar(
                              context,
                              'Please enter a valid OTP',
                              isError: true,
                            );
                          }
                        },
                        // fun: () {
                        //   Navigator.pushNamed(context, '/accountType');
                        // },
                        isColored: isButtonEnabled,
                        isEnabled: isButtonEnabled,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
