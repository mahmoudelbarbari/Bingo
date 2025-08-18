import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/home/presentaion/cubit/home_cubit.dart';
import 'package:bingo/features/home/presentaion/pages/get_all_peoduct_screen.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/categories_scroablle_widget.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/filter_btn_widget.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/slide_show_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/custom_textfield_for_search.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../product/presentation/cubit/product_cubit.dart';
import '../cubit/home_state.dart';
import 'widgets/product_list_Item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    final homeCubit = context.read<HomeCubit>();
    homeCubit.getThreeProducts();

    Future.delayed(Duration.zero, () {
      homeCubit.getCategories();
    });

    searchController.addListener(() {
      homeCubit.debouncer.run(() {
        homeCubit.searchProducts(searchController.text);
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await context.read<ProductCubit>().getAllProduct();
    await context.read<HomeCubit>().getThreeProducts();
    return Future.delayed(const Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final loc = AppLocalizations.of(context)!;
    return ChangeNotifierProvider.value(
      value: _pageController,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: BlocConsumer<HomeCubit, HomeState>(
                            listener: (context, state) {
                              if (state is SearchError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                            },
                            builder: (context, state) {
                              final cubit = context.read<HomeCubit>();
                              final isLoading = state is SearchLoading;

                              return TextFieldForSearch(
                                controller: searchController,
                                isRTL: isArabic,
                                isLoading: isLoading,
                                onClear: () => cubit.searchProducts(''),
                              );
                            },
                          ),
                        ),
                        FilterBtnWidget(),
                        SizedBox(width: 8.w),
                      ],
                    ),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is SearchLoaded) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              return ProductListItem(product: product);
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    SlideShowHomeWidget(),
                    SizedBox(height: 12.h),
                    Text(loc.discoverOurShops),
                    SizedBox(height: 12.h),
                    CategoriesScroablleWidget(),
                    SizedBox(height: 12.h),
                    GetAllPeoductScreen(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
