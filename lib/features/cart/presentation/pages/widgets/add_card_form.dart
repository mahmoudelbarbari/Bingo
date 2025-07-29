import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_dropdown_widget.dart';
import 'package:bingo/core/widgets/custome_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/util/validators.dart';
import '../../../../../core/widgets/custom_switch_widget.dart';
import '../../../../../core/widgets/dismiss_keyboared_scroll_view.dart';
import '../../../../../l10n/app_localizations.dart';

class AddCardForm extends StatefulWidget {
  final TextEditingController controllerCardNumber;
  final TextEditingController controllerName;
  final TextEditingController controllerExpirationDate;
  final TextEditingController controllerCVV;
  final TextEditingController controllerCardTypes;
  final bool isArabic;

  const AddCardForm({
    super.key,
    required this.controllerName,
    required this.controllerCVV,
    required this.controllerCardNumber,
    required this.controllerExpirationDate,
    required this.controllerCardTypes,
    required this.isArabic,
  });

  @override
  State<AddCardForm> createState() => _AddCardFormState();
}

class _AddCardFormState extends State<AddCardForm> {
  bool cardNumHasError = false;
  bool cardNumIsValid = false;

  bool nameHasError = false;
  bool nameIsValid = false;

  bool typesHasError = false;
  bool typesIsValid = false;

  bool expiryDateHasError = false;
  bool expiryDateIsValid = false;

  bool cvvHasError = false;
  bool cvvIsValid = false;

  bool defaultCard = false;
  bool termsConditions = false;
  List<String> cardTypesItems = ['Visa', 'Master Card'];
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final sizedBox = SizedBox(height: 14.h);
    var headlineMedium2 = Theme.of(context).textTheme.headlineMedium;
    return DismissKeyboardScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.cardNumber, style: headlineMedium2),
            sizedBox,
            CustomeTextfieldWidget(
              controller: widget.controllerCardNumber,
              hintlText: loc.cardNumber,
              isRTL: widget.isArabic,
              textInputType: TextInputType.number,
              formFieldValidator: (value) {
                final error = Validators.requiredField(value);
                setState(() {
                  cardNumHasError = error != null;
                  cardNumIsValid = error == null && value!.isNotEmpty;
                });
                return error;
              },
              hasError: cardNumHasError,
              isSuccess: cardNumIsValid,
            ),
            sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(loc.cardHolderName, style: headlineMedium2),
                      sizedBox,
                      CustomeTextfieldWidget(
                        controller: widget.controllerName,
                        hintlText: loc.cardHolderName,
                        isRTL: widget.isArabic,
                        formFieldValidator: (value) {
                          final error = Validators.requiredField(value);
                          setState(() {
                            nameHasError = error != null;
                            nameIsValid = error == null && value!.isNotEmpty;
                          });
                          return error;
                        },
                        hasError: nameHasError,
                        isSuccess: nameIsValid,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 7.w),
                Expanded(
                  child: CustomDropdown<String?>(
                    label: loc.selectCardType,
                    items: [loc.visa, loc.masterCard],
                    placeholder: loc.selectCardType,
                    dropDownValidator: (value) {
                      final error = Validators.requiredField(value);
                      setState(() {
                        typesHasError = error != null;
                        typesIsValid = error == null && value!.isNotEmpty;
                      });
                      return error;
                    },
                    onChanged: (v) {
                      widget.controllerCardTypes.text = v!;
                    },
                    hasError: typesHasError,
                    isSuccess: typesIsValid,
                  ),
                ),
              ],
            ),
            sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(loc.expiryDate, style: headlineMedium2),
                      sizedBox,
                      CustomeTextfieldWidget(
                        controller: widget.controllerExpirationDate,
                        textInputType: TextInputType.datetime,
                        hintlText: 'MM/YY',
                        isRTL: widget.isArabic,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          CardExpiryInputFormatter(),
                        ],
                        formFieldValidator: (value) {
                          final error = Validators.cardExpiryDate(value);
                          setState(() {
                            expiryDateHasError = error != null;
                            expiryDateIsValid =
                                error == null && value!.isNotEmpty;
                          });
                          return error;
                        },

                        hasError: expiryDateHasError,
                        isSuccess: expiryDateIsValid,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 7.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(loc.cvv, style: headlineMedium2),
                      sizedBox,
                      CustomeTextfieldWidget(
                        controller: widget.controllerCVV,
                        hintlText: loc.cvv,
                        textInputType: TextInputType.number,
                        isRTL: widget.isArabic,
                        formFieldValidator: (value) {
                          final error = Validators.requiredField(value);
                          setState(() {
                            cvvHasError = error != null;
                            cvvIsValid = error == null && value!.isNotEmpty;
                          });
                          return error;
                        },
                        hasError: cvvHasError,
                        isSuccess: cvvIsValid,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SwitchWidget(
              title: loc.defaultCard,
              value: defaultCard,
              onChanged: (bool newValue) {
                setState(() {
                  defaultCard = newValue;
                });
              },
            ),
            SwitchWidget(
              title: loc.agreeToTermsAndConditions,
              value: termsConditions,
              onChanged: (bool newValue) {
                setState(() {
                  termsConditions = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
