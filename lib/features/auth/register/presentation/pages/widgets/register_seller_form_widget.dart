import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/util/validators.dart';
import 'package:bingo/core/widgets/custome_textfield_widget.dart';
import 'package:bingo/features/auth/register/presentation/pages/widgets/countries_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:bingo/l10n/app_localizations.dart';

import '../../../domain/entities/countries_entity.dart';

class RegisterSellerFormWidget extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumbController;
  final TextEditingController addressController;
  final bool isArabic;
  final Function(CountriesEntity?)? onCountryChanged;
  final CountriesEntity? selectedCountry;

  const RegisterSellerFormWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneNumbController,
    required this.addressController,
    required this.isArabic,
    this.onCountryChanged,
    this.selectedCountry,
  });

  @override
  State<RegisterSellerFormWidget> createState() =>
      _RegisterSellerFormWidgetState();
}

class _RegisterSellerFormWidgetState extends State<RegisterSellerFormWidget> {
  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    var sizedBox = SizedBox(height: 16.h);
    return Column(
      children: [
        CustomeTextfieldWidget(
          controller: widget.nameController,
          labelText: loc.fullName,
          prefixIcon: Icon(Icons.person),
          isRTL: widget.isArabic,
          formFieldValidator: (value) {
            return Validators.requiredField(context, value);
          },
        ),
        sizedBox,
        CustomeTextfieldWidget(
          controller: widget.emailController,
          labelText: loc.yourEmail,
          prefixIcon: Icon(Icons.email),
          textInputType: TextInputType.emailAddress,
          isRTL: widget.isArabic,
          formFieldValidator: (value) {
            return Validators.email(context, value);
          },
        ),
        sizedBox,
        CustomeTextfieldWidget(
          controller: widget.phoneNumbController,
          labelText: loc.yourPhoneNumb,
          prefixIcon: Icon(Icons.phone_android_outlined),
          isRTL: widget.isArabic,
          formFieldValidator: (value) {
            return Validators.phoneNumber(context, value);
          },
        ),
        sizedBox,
        CountriesDropdownWidget(
          selectedCountry: widget.selectedCountry,
          onCountryChanged: widget.onCountryChanged!,
          isArabic: widget.isArabic,
          labelText: loc.country,
        ),
        sizedBox,
        CustomeTextfieldWidget(
          controller: widget.addressController,
          labelText: loc.address,
          prefixIcon: Icon(Icons.home_outlined),
          isRTL: widget.isArabic,
          formFieldValidator: (value) {
            return Validators.requiredField(context, value);
          },
        ),
        sizedBox,
        CustomeTextfieldWidget(
          controller: widget.passwordController,
          labelText: loc.yourPassword,
          prefixIcon: Icon(Icons.lock),
          isobscureText: true,
          isRTL: widget.isArabic,

          formFieldValidator: (value) {
            return Validators.password(context, value);
          },
        ),
      ],
    );
  }
}
