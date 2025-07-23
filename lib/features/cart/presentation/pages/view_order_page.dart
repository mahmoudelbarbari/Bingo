import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custome_snackbar_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import 'widgets/view_order_widget.dart';

class ViewOrderPage extends StatelessWidget {
  const ViewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CartCubit()..viewOrder(),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartError) {
              showAppSnackBar(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return const LoadingWidget();
            } else if (state is CartItemsLoadded) {
              return ViewOrderWidget(menuModel: state.prodcutModel);
            }
            return const Center(
              child: Text(
                "You don't have any past orders...!",
                style: TextStyle(fontSize: 15),
              ),
            );
          },
        ),
      ),
    );
  }
}
