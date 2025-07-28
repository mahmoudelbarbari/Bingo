import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/Credit_card_layout_widget.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/add_card_form.dart';
import 'package:flutter/material.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/cart/presentation/pages/widgets/cart_progress_widget.dart';

import '../../../../l10n/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
  final String totalCart;

  const PaymentScreen({super.key, required this.totalCart});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late TextEditingController controllerCardNumber;
  late TextEditingController controllerName;
  late TextEditingController controllerExpirationDate;
  late TextEditingController controllerCVV;
  late TextEditingController controllerCardTypes;
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    controllerCardNumber = TextEditingController();
    controllerName = TextEditingController();
    controllerExpirationDate = TextEditingController();
    controllerCVV = TextEditingController();
    controllerCardTypes = TextEditingController();
    controllerCardNumber.addListener(_validateForm);
    controllerName.addListener(_validateForm);
    controllerExpirationDate.addListener(_validateForm);
    controllerCVV.addListener(_validateForm);
    controllerCardTypes.addListener(_validateForm);
  }

  void _validateForm() {
    final cardNumFilled = controllerCardNumber.text.trim().isNotEmpty;
    final nameFilled = controllerName.text.isNotEmpty;

    final expiryDateFilled = controllerExpirationDate.text.trim().isNotEmpty;
    final cvvFilled = controllerCVV.text.isNotEmpty;
    final typesFilled = controllerCardTypes.text.isNotEmpty;

    setState(() {
      isButtonEnabled =
          (cardNumFilled && nameFilled) &&
          (expiryDateFilled && cvvFilled) &&
          typesFilled;
    });
  }

  @override
  void dispose() {
    controllerCardNumber.removeListener(_validateForm);
    controllerName.removeListener(_validateForm);
    controllerCardNumber.dispose();
    controllerName.dispose();

    controllerExpirationDate.removeListener(_validateForm);
    controllerCVV.removeListener(_validateForm);
    controllerExpirationDate.dispose();
    controllerCVV.dispose();

    controllerCardTypes.removeListener(_validateForm);
    controllerCardTypes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    var sizedBox = SizedBox(height: 24.h);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          loc.payment,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CartProgressWidget(
                  title: loc.order,
                  icon: Icons.shopping_cart_sharp,
                  isSelected: true,
                ),
                CartProgressWidget(
                  title: loc.address,
                  icon: Icons.location_city,
                  isSelected: true,
                ),
                CartProgressWidget(
                  title: loc.payment,
                  icon: Icons.payment_outlined,
                  isSelected: true,
                ),
              ],
            ),
            sizedBox,
            CreditCardLayoutWidget(),
            Expanded(
              child: Form(
                key: _keyform,
                child: AddCardForm(
                  controllerName: controllerName,
                  controllerCVV: controllerCVV,
                  controllerCardNumber: controllerCardNumber,
                  controllerExpirationDate: controllerExpirationDate,
                  controllerCardTypes: controllerCardTypes,
                  isArabic: isArabic,
                ),
              ),
            ),
            ElevatedButtonWidget(
              fun: () {
                setState(() {
                  if (_keyform.currentState!.validate()) {
                    print(
                      '${controllerCardNumber.text} && ${controllerName.text} && ${controllerCardTypes.text} && ${controllerExpirationDate.text} && ${controllerCVV.text}',
                    );
                  }
                });
              },
              text: '${loc.pay} ${widget.totalCart} ${loc.egp}',
              isColored: true,
            ),
            sizedBox,
          ],
        ),
      ),
    );
  }
}
