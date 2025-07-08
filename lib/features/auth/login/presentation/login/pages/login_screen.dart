import 'package:bingo/Alshimaa.dart';
import 'package:bingo/features/auth/login/presentation/login/cubit/login_cubit.dart';
import 'package:bingo/features/auth/login/presentation/login/cubit/login_state.dart';
import 'package:bingo/features/auth/login/presentation/login/pages/widgets/login_form.dart';
import 'package:bingo/features/auth/login/presentation/login/pages/widgets/social_icon_button_widget.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/custom_alert_dialog.dart';
import '../../../../../../core/widgets/welcome_header_widget.dart';
import '../../../../../../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
    passwordVisible = true;
    controllerEmail.addListener(_validateForm);
    controllerPassword.addListener(_validateForm);
  }

  void _validateForm() {
    final emailFilled = controllerEmail.text.trim().isNotEmpty;
    final passwordFilled = controllerPassword.text.isNotEmpty;

    setState(() {
      isButtonEnabled = emailFilled && passwordFilled;
    });
  }

  @override
  void dispose() {
    controllerEmail.removeListener(_validateForm);
    controllerPassword.removeListener(_validateForm);
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    message: state.message,
                    isSuccess: true,
                  ),
                );
              }
              if (state is LoginErrorState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    message: state.errorMessage,
                    isSuccess: false,
                  ),
                );
              }
            },
            builder: (context, state) {
              final sizeBox = SizedBox(height: 24);
              return Form(
                key: _keyform,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Column(
                      children: [
                        WelcomeHeaderWidget(
                          imageURL: Assets.images.bingoLogo1.path,
                          headerText1: '${loc.greateToSeeYouHere} ',
                          headerText2: '${loc.back} !',
                          icon: Icons.abc_outlined,
                          headerSubText: loc.justLogInAndHavefun,
                        ),
                        sizeBox,
                        LoginForm(
                          emailController: controllerEmail,
                          passwordController: controllerPassword,
                          isArabic: isArabic,
                        ),
                        sizeBox,
                        ElevatedButtonWidget(
                          fun: () {
                            setState(() {
                              if (_keyform.currentState!.validate()) {
                                context.read<LoginCubit>().remoteLogin(
                                  controllerEmail.text.trim(),
                                  controllerPassword.text,
                                  context,
                                );
                              }
                            });
                          },
                          text: loc.login,
                          isColored: isButtonEnabled,
                          isEnabled: isButtonEnabled,
                        ),
                        DividerWidget(),
                        sizeBox,
                        SocialIconButton(),
                        sizeBox,
                        TextButtonWidget(
                          fun: () {},
                          text1: loc.dontHaveAnAccount,
                          text2: loc.signUp,
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
