import 'package:bingo/features/home/presentaion/pages/widgets/all_product_widget.dart';
import 'package:bingo/features/profile/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:bingo/features/profile/presentation/cubit/product_cubit/product_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';

class GetAllPeoductScreen extends StatefulWidget {
  const GetAllPeoductScreen({super.key});

  @override
  State<GetAllPeoductScreen> createState() => _GetAllPeoductScreenState();
}

class _GetAllPeoductScreenState extends State<GetAllPeoductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return const LoadingWidget();
        } else if (state is ProductLoadedState) {
          return AllProductWidget(productEntity: state.productEntity);
        } else if (state is ProductErrorState) {
          if (kDebugMode) {
            print(state.errorMessage);
          }
        }
        return const LoadingWidget();
      },
      listener: (context, state) {
        if (state is ProductErrorState) {
          if (kDebugMode) {
            print(state.errorMessage);
          }
        }
      },
    );
  }
}
