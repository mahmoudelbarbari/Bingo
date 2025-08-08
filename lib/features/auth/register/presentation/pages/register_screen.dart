import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:bingo/features/auth/register/presentation/cubit/register_state.dart';
import 'package:bingo/features/auth/register/presentation/pages/seller_otp_verification/seller_otp_verification_screen.dart';
import 'package:bingo/features/auth/register/presentation/pages/widgets/register_seller_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:bingo/core/widgets/custom_alert_dialog.dart';
import 'package:bingo/core/widgets/custom_divider_widget.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/core/widgets/custom_text_button.dart';
import 'package:bingo/core/widgets/welcome_header_widget.dart';
import 'package:bingo/features/auth/register/presentation/pages/widgets/register_form.dart';
import 'package:bingo/l10n/app_localizations.dart';

import '../../../login/presentation/otp_verification/otp_verification_screen.dart';
import '../../domain/entities/countries_entity.dart';

class RegisterScreen extends StatefulWidget {
  final String selectType;
  const RegisterScreen({super.key, required this.selectType});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneNumbController;
  late TextEditingController confirmPasswordController;
  late TextEditingController addressController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;
  CountriesEntity? selectedCountry;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumbController = TextEditingController();
    addressController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    phoneNumbController.addListener(_validateForm);
    addressController.addListener(_validateForm);
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

  void _onCountryChanged(CountriesEntity? country) {
    setState(() {
      selectedCountry = country;
    });
    _validateForm();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumbController.dispose();
    addressController.dispose();
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
              if (state is RegisterSuccessState &&
                  widget.selectType == 'Buyer') {
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpVerificationScreen(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text,
                      ),
                    ),
                  );
                }
              } else if (state is SellerRegisterSuccessState &&
                  widget.selectType == "Seller") {
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SellerOtpVerificationScreen(
                        sellerAccountModel: SellerAccountModel(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          country: selectedCountry!.name,
                          phoneNum: phoneNumbController.text,
                        ),
                      ),
                    ),
                  );
                }
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Column(
                      children: [
                        WelcomeHeaderWidget(
                          imageURL: Assets.images.bingologo2.path,
                          headerText1: '${loc.letsGetStarted} ',
                          headerText2: '${loc.signUp}!',
                          icon: Icons.person_add_alt_1_outlined,
                          headerSubText: loc.createAnAccountToContinue,
                        ),
                        const SizedBox(height: 24),
                        widget.selectType == 'Buyer'
                            ? RegisterForm(
                                nameController: nameController,
                                emailController: emailController,
                                passwordController: passwordController,
                                isArabic: isArabic,
                                confirmPasswordController:
                                    confirmPasswordController,
                              )
                            : RegisterSellerFormWidget(
                                nameController: nameController,
                                emailController: emailController,
                                passwordController: passwordController,
                                addressController: addressController,
                                selectedCountry: selectedCountry,
                                onCountryChanged: _onCountryChanged,
                                phoneNumbController: phoneNumbController,
                                isArabic: isArabic,
                              ),
                        const SizedBox(height: 24),
                        ElevatedButtonWidget(
                          fun: widget.selectType == 'Buyer'
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<RegisterCubit>().registerUser(
                                      nameController.text.trim(),
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                      context,
                                    );
                                  }
                                }
                              : () {
                                  if (selectedCountry != null &&
                                      _formKey.currentState!.validate()) {
                                    context
                                        .read<RegisterCubit>()
                                        .registerSeller(
                                          SellerAccountModel(
                                            name: nameController.text.trim(),
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim(),
                                            country: selectedCountry!.name,
                                            phoneNum: phoneNumbController.text,
                                          ),
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
                            Navigator.pushNamed(context, '/loginScreen');
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
