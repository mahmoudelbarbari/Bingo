import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../../core/util/validators.dart';
import '../../../../../core/widgets/custome_textfield_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/app_localizations.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isArabic;

  const RegisterForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isArabic,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    SizeConfig.init(context);

    return Column(
      children: [
        /// Full Name
        CustomeTextfieldWidget(
          controller: widget.nameController,
          prefixIcon: const Icon(Icons.person),
          labelText: loc.userName,
          isRTL: widget.isArabic,
          formFieldValidator: (value) =>
              Validators.requiredField(value, message: loc.requiredField),
        ),
        SizedBox(height: 20.h),

        /// Email
        CustomeTextfieldWidget(
          controller: widget.emailController,
          prefixIcon: const Icon(Icons.email),
          labelText: loc.yourEmail,
          isRTL: widget.isArabic,
          formFieldValidator: (value) =>
              Validators.email(value),
        ),
        SizedBox(height: 20.h),

        /// Password
        CustomeTextfieldWidget(
          controller: widget.passwordController,
          isRTL: widget.isArabic,
          prefixIcon: Image.asset(Assets.images.lockIcon.path),
          labelText: loc.yourPassword,
          isobscureText: !passwordVisible,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
            icon: Icon(
              passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          formFieldValidator: (value) => Validators.password(
            value,
            message: loc.invalidPassword,
          ),
        ),
        SizedBox(height: 20.h),

        /// Confirm Password
        CustomeTextfieldWidget(
          controller: widget.confirmPasswordController,
          isRTL: widget.isArabic,
          prefixIcon: Image.asset(Assets.images.lockIcon.path),
          labelText: loc.confirmPassword,
          isobscureText: !confirmPasswordVisible,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                confirmPasswordVisible = !confirmPasswordVisible;
              });
            },
            icon: Icon(
              confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          formFieldValidator: (value) => Validators.match(
            value,
            widget.passwordController.text,
            message: loc.passwordsDoNotMatch,
          ),
        ),
      ],
    );
  }
}
