import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/core/widgets/custom_user_type.dart';
import 'package:bingo/core/widgets/welcome_header_widget.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AccountTypePage extends StatefulWidget {
  const AccountTypePage({super.key});

  @override
  State<AccountTypePage> createState() => _AccountTypePageState();
}

class _AccountTypePageState extends State<AccountTypePage> {
  String? selectedType;

  // Track selected type
  void userType(String type) {
    setState(() {
      selectedType = type;
    });
  }

  void continueToNext() {
    if (selectedType != null) {
      print(selectedType);
      Navigator.pushNamed(context, '/register', arguments: selectedType);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: ListView(
        children: [
          WelcomeHeaderWidget(
            imageURL: Assets.images.bingoLogo1.path,
            headerText1: loc.areYouASellerOrBuyer,
            headerSubText:
                '${loc.buyingOrSellingWeHaveGotYourBackAndMake} \n                        ${loc.itSuperEasyForYou}',
          ),
          SizedBox(height: 12.h),
          UserTypeSelector(
            options: [
              UserTypeOption(
                text: loc.seller,
                displayText: loc.seller,
                value: 'Seller',
                imgPath: Assets.images.sellerImg.path,
              ),
              UserTypeOption(
                text: loc.buyer,
                displayText: loc.buyer,
                value: 'Buyer',
                imgPath: Assets.images.buyerImg.path,
              ),
            ],
            onSelected: userType,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.all(12.w),
        child: ElevatedButtonWidget(
          fun: continueToNext,
          text: loc.continu,
          isColored: selectedType != null,
          isEnabled: selectedType != null,
        ),
      ),
    );
  }
}
