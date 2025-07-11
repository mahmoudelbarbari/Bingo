import 'package:bingo/features/register/presentation/cubit/register_cubit.dart';
import 'package:bingo/features/register/presentation/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:bingo/core/widgets/custom_alert_dialog.dart';
import 'package:bingo/core/widgets/custom_divider_widget.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/core/widgets/custom_text_button.dart';
import 'package:bingo/core/widgets/welcome_header_widget.dart';
import 'package:bingo/features/register/presentation/pages/widgets/register_form.dart';
import 'package:bingo/l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    final isNameFilled = nameController.text.trim().isNotEmpty;
    final isEmailFilled = emailController.text.trim().isNotEmpty;
    final isPasswordFilled = passwordController.text.isNotEmpty;

    setState(() {
      isButtonEnabled = isNameFilled && isEmailFilled && isPasswordFilled;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
          create: (context) => RegisterCubit(),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    message: state.message,
                    isSuccess: true,
                  ),
                );
              } else if (state is RegisterErrorState) {
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
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      children: [
                        WelcomeHeaderWidget(
                          imageURL: Assets.images.bingoLogo1.path,
                          headerText1: '${loc.letsGetStarted} ',
                          headerText2: '${loc.signUp}!',
                          icon: Icons.person_add_alt_1_outlined,
                          headerSubText: loc.createAnAccountToContinue,
                        ),
                        const SizedBox(height: 24),
                        RegisterForm(
                          nameController: nameController,
                          emailController: emailController,
                          passwordController: passwordController,
                          isArabic: isArabic,
                          confirmPasswordController: confirmPasswordController,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButtonWidget(
                          fun: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<RegisterCubit>().registerUser(
                                    nameController.text.trim(),
                                    emailController.text.trim(),
                                    passwordController.text,
                                  
                                    context,
                                  );
                            }
                          },
                          text: loc.signUp,
                          isColored: isButtonEnabled,
                          isEnabled: isButtonEnabled,
                        ),
                        DividerWidget(),
                        const SizedBox(height: 24),
                        TextButtonWidget(
                          fun: () {
                            Navigator.pop(context); 
                          },
                          text1: loc.dontHaveAnAccount,
                          text2: loc.login,
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
