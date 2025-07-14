import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/util/validators.dart';
import '../../../../../../../core/widgets/custome_textfield_widget.dart';
import '../../../../../../../gen/assets.gen.dart';
import '../../../../../../../l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isArabic;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isArabic,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isChecked = true;
  bool passwordVisible = false;

  bool emailHasError = false;
  bool emailIsValid = false;

  bool passHasError = false;
  bool passIsValid = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    SizeConfig.init(context);
    return Column(
      children: [
        CustomeTextfieldWidget(
          controller: widget.emailController,
          prefixIcon: Icon(Icons.email),
          formFieldValidator: (value) {
            final error = Validators.email(value);
            setState(() {
              emailHasError = error != null;
              emailIsValid = error == null && value!.isNotEmpty;
            });
            return error;
          },
          labelText: loc.yourEmail,
          isRTL: widget.isArabic,
          hasError: emailHasError,
          isSuccess: emailIsValid,
        ),

        SizedBox(height: 20.h),
        CustomeTextfieldWidget(
          controller: widget.passwordController,
          isRTL: widget.isArabic,
          prefixIcon: Image.asset(Assets.images.lockIcon.path),
          labelText: loc.yourPassword,
          isobscureText: passwordVisible,
          formFieldValidator: (v) {
            final error = Validators.password(v);
            setState(() {
              passHasError = error != null;
              passIsValid = error == null && v!.isNotEmpty;
            });
            return error;
          },
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
            icon: Icon(
              passwordVisible ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          hasError: passHasError,
          isSuccess: passIsValid,
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                      Text(
                        loc.remmberMe,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/forgetPassword');
                },
                child: Text(
                  loc.forgotPassword,
                  style: TextStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
