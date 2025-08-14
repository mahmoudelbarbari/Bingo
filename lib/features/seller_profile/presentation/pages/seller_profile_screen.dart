import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../gen/assets.gen.dart';
import '../../../profile/presentation/cubit/language_cubit/language_cubit.dart';
import '../../../profile/presentation/cubit/theme_cubit/theme_cubit.dart';
import '../Customswidgets/eventProfile.dart';
import '../Customswidgets/product_tab.dart';
import '../Customswidgets/profile_header.dart';
import '../Customswidgets/review.dart';
import '../cubit/seller_profile_cubit.dart';
import '../cubit/seller_profile_state.dart';

class SellerProfileScreen extends StatefulWidget {
  final String sellerId;
  const SellerProfileScreen({super.key, required this.sellerId});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    final cubit = context.read<SellerProfileCubit>();
    cubit.fetchSellerProfile(widget.sellerId);
    cubit.fetchSellerProducts(widget.sellerId);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final index = _tabController.index;
      if (index == 1) {
        cubit.fetchSellerEvents(widget.sellerId);
      } else if (index == 2) {
        cubit.fetchSellerReviews(widget.sellerId);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final languageCubit = context.read<LanguageCubit>();
    final currentLanguage = languageCubit.state.languageCode;

    return BlocBuilder<SellerProfileCubit, SellerProfileState>(
      builder: (context, state) {
        if (state.isProfileLoading && state.profile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = state.profile;
        final seller = state.shopEntity;
        final sellerName = seller?.name ?? 'Seller Name';
        final isVerified = profile?.isVerified ?? false;
        final sellerImage = profile?.imageUrl ?? '';
        final cover = profile?.coverBanner ?? '';

        return Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ProfileHeader(
                  profileImageUrl: sellerImage,
                  coverImageUrl: cover,
                ),
              ],
            ),
            SizedBox(height: 48.h),
            Row(
              children: [
                Spacer(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sellerName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      if (isVerified)
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 18,
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 30.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<ThemeCubit, ThemeMode>(
                      builder: (context, themeMode) {
                        final isDark = themeMode == ThemeMode.dark;
                        return IconButton(
                          icon: Icon(
                            isDark ? Icons.light_mode : Icons.dark_mode,
                            size: 20,
                          ),
                          onPressed: () {
                            final newMode = isDark
                                ? ThemeMode.light
                                : ThemeMode.dark;
                            context.read<ThemeCubit>().updateTheme(newMode);
                          },
                        );
                      },
                    ),

                    // Language toggle button
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(40.w, 40.h),
                      ),
                      child: Text(
                        currentLanguage == 'en' ? 'EN' : 'AR',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        languageCubit.toggleLanguage();
                      },
                    ),
                  ],
                ),
              ],
            ),

            Text(
              state.shopEntity!.bio ?? loc.specializedInHandMadeCrafts,
              style: const TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16.h),
            // const ButtonSeller(),
            SizedBox(height: 16.h),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIcon(AssetImage(Assets.images.package.path)),
                      SizedBox(width: 6.w),
                      Text(loc.products),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.event),
                      SizedBox(width: 6.w),
                      Text(loc.events),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star),
                      SizedBox(width: 6.w),
                      Text(loc.reviews),
                    ],
                  ),
                ),
              ],
              labelColor: lightTheme.colorScheme.primary,
              indicatorColor: lightTheme.colorScheme.primary,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  state.isProductsLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ProductsTab(products: state.products),
                  state.isEventsLoading
                      ? const Center(child: CircularProgressIndicator())
                      : EventsTab(events: state.events),
                  state.isReviewsLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ReviewsTab(reviews: state.reviews),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
