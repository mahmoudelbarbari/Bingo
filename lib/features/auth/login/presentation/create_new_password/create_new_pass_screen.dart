import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/validators.dart';
import '../../../../../core/widgets/custom_alert_dialog.dart';
import '../../../../../core/widgets/custome_textfield_widget.dart';
import '../../../../../core/widgets/welcome_header_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/app_localizations.dart';
import '../forget_password/cubit/forget_pass_cubit.dart';
import '../forget_password/cubit/forget_pass_state.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  late final TextEditingController controllerPassword;
  late final TextEditingController controllerConfirmPassword;
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  bool isButtonEnabled = false;
  bool passwordVisible = false;
  bool confPasswordVisible = false;

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
    controllerPassword = TextEditingController();
    controllerConfirmPassword = TextEditingController();
    controllerPassword.addListener(_validateForm);
    controllerConfirmPassword.addListener(_validateForm);
  }

  void _validateForm() {
    final passwordFilled = controllerPassword.text.trim().isNotEmpty;
    final confrimPassFilled = controllerConfirmPassword.text.isNotEmpty;
    setState(() {
      isButtonEnabled = passwordFilled;
      isButtonEnabled = confrimPassFilled;
    });
  }

  @override
  void dispose() {
    controllerPassword.removeListener(_validateForm);
    controllerConfirmPassword.removeListener(_validateForm);
    controllerPassword.dispose();
    controllerConfirmPassword.dispose();
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
              if (state is ForgotPasswordSuccess) {
                showAppSnackBar(context, loc.passwordCreatedSuccessfully);
              }
              if (state is ForgotPasswordError) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    message: state.message,
                    isSuccess: false,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _keyform,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 15.w,
                  ),
                  child: Column(
                    children: [
                      WelcomeHeaderWidget(
                        imageURL: Assets.images.bingoLogo1.path,
                        headerText1: loc.createNewPassword,
                        headerSubText: loc.enterYourNewPassword,
                      ),
                      SizedBox(height: 24.h),
                      CustomeTextfieldWidget(
                        controller: controllerPassword,
                        labelText: loc.yourPassword,
                        prefixIcon: Image.asset(Assets.images.lockIcon.path),
                        isRTL: isArabic,
                        isobscureText: passwordVisible,
                        formFieldValidator: (value) {
                          return Validators.password(context, value);
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomeTextfieldWidget(
                        controller: controllerConfirmPassword,
                        labelText: loc.confirmPassword,
                        prefixIcon: Image.asset(Assets.images.lockIcon.path),
                        isRTL: isArabic,
                        isobscureText: confPasswordVisible,
                        formFieldValidator: (value) => Validators.match(
                          context,
                          value?.trim(),
                          controllerPassword.text.trim(),
                          message: loc.passwordsDoNotMatch,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              confPasswordVisible = !confPasswordVisible;
                            });
                          },
                          icon: Icon(
                            confPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButtonWidget(
                        fun: () {
                          if (_keyform.currentState!.validate()) {
                            context.read<ForgotPasswordCubit>().resetPassword(
                              email,
                              controllerConfirmPassword.text.trim(),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
