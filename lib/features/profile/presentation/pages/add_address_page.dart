import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/util/validators.dart';
import 'package:bingo/core/widgets/custome_textfield_widget.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/core/widgets/dismiss_keyboared_scroll_view.dart';
import 'package:bingo/features/profile/domain/entity/user.dart';
import 'package:bingo/features/profile/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custome_snackbar_widget.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers for form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  // Checkbox state
  bool _isDefaultAddress = false;

  // Form validation states
  bool _fullNameHasError = false;
  bool _fullNameIsValid = false;
  bool _streetAddressHasError = false;
  bool _streetAddressIsValid = false;
  bool _cityHasError = false;
  bool _cityIsValid = false;
  bool _stateHasError = false;
  bool _stateIsValid = false;
  bool _zipCodeHasError = false;
  bool _zipCodeIsValid = false;
  bool _countryHasError = false;
  bool _countryIsValid = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  List<String?> labelItems = ['Home', 'Work', 'Other'];
  String? selectedAddress = 'Home';

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement address saving logic
      // You can add your API call or local storage logic here
      // Example of collecting form data
      final addressData = AddressEntity(
        name: _fullNameController.text.trim(),
        city: _cityController.text.trim(),
        country: _countryController.text.trim(),
        isDefault: _isDefaultAddress,
        state: _stateController.text.trim(),
        streetAddress: _streetAddressController.text.trim(),
        zipCode: _zipCodeController.text.trim(),
        label: selectedAddress,
      );
      context.read<UserCubit>().addUserAddress(addressData, context);
      showAppSnackBar(context, "Address saved successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          loc.newAddress,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: DismissKeyboardScrollView(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  value: selectedAddress,
                  items: labelItems
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item ?? ''),
                        ),
                      )
                      .toList(),
                  onChanged: (item) => setState(() {
                    selectedAddress = item;
                  }),
                ),
                SizedBox(height: 20.h),
                // Full Name Field
                CustomeTextfieldWidget(
                  controller: _fullNameController,
                  prefixIcon: Icon(Icons.person),
                  labelText: loc.fullName,
                  hintlText: loc.enterYourFullName,
                  isRTL: isArabic,
                  textInputType: TextInputType.name,
                  hasError: _fullNameHasError,
                  isSuccess: _fullNameIsValid,
                  formFieldValidator: (value) {
                    final error = Validators.requiredField(context, value);
                    setState(() {
                      _fullNameHasError = error != null;
                      _fullNameIsValid = error == null && value!.isNotEmpty;
                    });
                    return error;
                  },
                ),
                SizedBox(height: 20.h),

                // Street Address Field
                CustomeTextfieldWidget(
                  controller: _streetAddressController,
                  prefixIcon: Icon(Icons.home),
                  labelText: loc.streetAddress,
                  hintlText: loc.enterYourStreetAddress,
                  isRTL: isArabic,
                  textInputType: TextInputType.streetAddress,
                  hasError: _streetAddressHasError,
                  isSuccess: _streetAddressIsValid,
                  formFieldValidator: (value) {
                    final error = Validators.requiredField(context, value);
                    setState(() {
                      _streetAddressHasError = error != null;
                      _streetAddressIsValid =
                          error == null && value!.isNotEmpty;
                    });
                    return error;
                  },
                ),
                SizedBox(height: 20.h),

                // City Field
                CustomeTextfieldWidget(
                  controller: _cityController,
                  prefixIcon: Icon(Icons.location_city),
                  labelText: loc.city,
                  hintlText: loc.enterYourCity,
                  isRTL: isArabic,
                  textInputType: TextInputType.text,
                  hasError: _cityHasError,
                  isSuccess: _cityIsValid,
                  formFieldValidator: (value) {
                    final error = Validators.requiredField(context, value);
                    setState(() {
                      _cityHasError = error != null;
                      _cityIsValid = error == null && value!.isNotEmpty;
                    });
                    return error;
                  },
                ),
                SizedBox(height: 20.h),

                // State/Province Field
                CustomeTextfieldWidget(
                  controller: _stateController,
                  prefixIcon: Icon(Icons.map),
                  labelText: loc.stateProvince,
                  hintlText: loc.enterYourSateOrProvince,
                  isRTL: isArabic,
                  textInputType: TextInputType.text,
                  hasError: _stateHasError,
                  isSuccess: _stateIsValid,
                  formFieldValidator: (value) {
                    final error = Validators.requiredField(
                      context,
                      value,
                      message: loc.stateProvinceIsRequired,
                    );
                    setState(() {
                      _stateHasError = error != null;
                      _stateIsValid = error == null && value!.isNotEmpty;
                    });
                    return error;
                  },
                ),
                SizedBox(height: 20.h),

                // ZIP Code Field
                CustomeTextfieldWidget(
                  controller: _zipCodeController,
                  prefixIcon: Icon(Icons.pin_drop),
                  labelText: loc.zipCode,
                  hintlText: loc.enterYourZIPCode,
                  isRTL: isArabic,
                  textInputType: TextInputType.number,
                  hasError: _zipCodeHasError,
                  isSuccess: _zipCodeIsValid,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  formFieldValidator: (value) {
                    final error = Validators.requiredField(
                      context,
                      value,
                      message: loc.zipCodeIsRequired,
                    );
                    setState(() {
                      _zipCodeHasError = error != null;
                      _zipCodeIsValid = error == null && value!.isNotEmpty;
                    });
                    return error;
                  },
                ),
                SizedBox(height: 20.h),

                // Country Field
                CustomeTextfieldWidget(
                  controller: _countryController,
                  prefixIcon: Icon(Icons.public),
                  labelText: loc.country,
                  hintlText: loc.enterYourCountry,
                  isRTL: isArabic,
                  textInputType: TextInputType.text,
                  hasError: _countryHasError,
                  isSuccess: _countryIsValid,
                  formFieldValidator: (value) {
                    final error = Validators.requiredField(
                      context,
                      value,
                      message: loc.countryIsRequired,
                    );
                    setState(() {
                      _countryHasError = error != null;
                      _countryIsValid = error == null && value!.isNotEmpty;
                    });
                    return error;
                  },
                ),
                SizedBox(height: 24.h),

                // Set as Default Address Checkbox
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: CheckboxListTile(
                    title: Text(
                      loc.setAsDefaultAddress,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      loc.thisAddressWillBeYsedAsYourDefaultShippingAddress,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    value: _isDefaultAddress,
                    onChanged: (bool? value) {
                      setState(() {
                        _isDefaultAddress = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),

                // Save Address Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButtonWidget(
                    fun: _saveAddress,
                    text: loc.saveAddress,
                    isColored: true,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
