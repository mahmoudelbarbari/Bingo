import 'package:bingo/features/product/presentation/cubit/product_cubit.dart';
import 'package:bingo/features/product/presentation/cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_alert_dialog.dart';
import '../../../../core/widgets/custome_snackbar_widget.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductAddedSuccess) {
            showAppSnackBar(context, state.message);
          } else if (state is ProductErrorState) {
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
          final isArabic = Localizations.localeOf(context).languageCode == 'ar';
          return Form(
            key: _keyform,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
