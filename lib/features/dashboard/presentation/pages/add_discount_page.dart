import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/util/validators.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/core/widgets/custome_textfield_widget.dart';
import 'package:bingo/features/dashboard/domain/entity/discount_code_entity.dart';
import 'package:bingo/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:bingo/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/dismiss_keyboared_scroll_view.dart';

class AddDiscountPage extends StatefulWidget {
  const AddDiscountPage({super.key});

  @override
  State<AddDiscountPage> createState() => _AddDiscountPageState();
}

class _AddDiscountPageState extends State<AddDiscountPage> {
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dicountValueController = TextEditingController();
  final _discountCodeController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _dicountValueController.dispose();
    _discountCodeController.dispose();
    super.dispose();
  }

  List<String?> labelItems = ['percentage', "flat"];
  String? selectedDiscountType;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final loc = AppLocalizations.of(context)!;
    String _localizedLabel(AppLocalizations loc, String key) {
      switch (key) {
        case 'percentage':
          return loc.discountPercentage;
        case 'flat':
          return loc.discountFixedAmount;
        default:
          return key;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(loc.createDiscountCode), centerTitle: true),
      body: BlocListener<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state is AddDiscountCodeSuccess) {
            showAppSnackBar(context, loc.discountCodeAddedSuccessfully);
          } else if (state is AddDiscountCodeError) {
            showAppSnackBar(context, loc.somethingWentWrong, isError: true);
          }
        },
        child: DismissKeyboardScrollView(
          child: Form(
            key: _keyform,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  CustomeTextfieldWidget(
                    controller: _titleController,
                    isRTL: isArabic,
                    labelText: loc.discountTitle,
                    hintlText: loc.egSummerSaleBlackFridayDeal,
                    formFieldValidator: (value) {
                      return Validators.requiredField(context, value);
                    },
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: DropdownButtonFormField<String>(
                          hint: Text(loc.discountType),
                          isExpanded: true,
                          value: selectedDiscountType,
                          validator: (value) {
                            return Validators.requiredField(context, value);
                          },
                          items: labelItems
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(_localizedLabel(loc, item ?? '')),
                                ),
                              )
                              .toList(),
                          onChanged: (item) => setState(() {
                            selectedDiscountType = item;
                          }),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        flex: 5,
                        child: CustomeTextfieldWidget(
                          controller: _dicountValueController,
                          isRTL: isArabic,
                          textInputType: TextInputType.number,
                          hintlText: '10',
                          labelText: loc.discountyValue,
                          formFieldValidator: (value) {
                            return Validators.requiredField(context, value);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  CustomeTextfieldWidget(
                    controller: _discountCodeController,
                    isRTL: isArabic,
                    labelText: loc.discountCode,
                    hintlText: loc.egSummer2023Save15,
                    formFieldValidator: (value) {
                      return Validators.requiredField(context, value);
                    },
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButtonWidget(
                    text: '+  ${loc.createDiscount}',
                    isColored: true,
                    fun: () {
                      if (_keyform.currentState!.validate()) {
                        context.read<DashboardCubit>().addDiscountCode(
                          DiscountCodeEntity(
                            publicName: _titleController.text.trim(),
                            discountCode: _discountCodeController.text.trim(),
                            discountType: selectedDiscountType,
                            discountValue: int.parse(
                              _dicountValueController.text.trim(),
                            ),
                          ),
                          context,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
