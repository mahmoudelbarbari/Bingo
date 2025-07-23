import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/home/presentaion/pages/get_all_peoduct_screen.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/categories_scroablle_widget.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/filter_btn_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_textfield_for_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: TextFieldForSearch(
                  controller: searchController,
                  isRTL: isArabic,
                ),
              ),
              FilterBtnWidget(),
              SizedBox(width: 8.w),
            ],
          ),
          SizedBox(height: 12.h),
          CategoriesScroablleWidget(),
          SizedBox(height: 12.h),
          Expanded(child: GetAllPeoductScreen()),
        ],
      ),
    );
  }
}
