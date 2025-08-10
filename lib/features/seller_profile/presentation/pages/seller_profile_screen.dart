import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../gen/assets.gen.dart';
import '../Customswidgets/ButtonSaller.dart';
import '../Customswidgets/eventProfile.dart';
import '../Customswidgets/product_tab.dart';
import '../Customswidgets/profile_header.dart' show ProfileHeader;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seller Profile',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Stack(clipBehavior: Clip.none, children: [ProfileHeader()]),
          const SizedBox(height: 48),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ahmed Tarek',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              Icon(Icons.verified, color: Colors.blue, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Specialized in hand-made crafts',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ButtonSeller(),
          const SizedBox(height: 16),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(AssetImage(Assets.images.package.path)),
                    SizedBox(width: 6.w),
                    Text('Products'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event),
                    SizedBox(width: 6),
                    Text('Events'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star),
                    SizedBox(width: 6),
                    Text('Reviews'),
                  ],
                ),
              ),
            ],
            labelColor: lightTheme.colorScheme.primary,
            unselectedLabelColor: Colors.black54,
            indicatorColor: lightTheme.colorScheme.primary,
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                BlocBuilder<SellerProfileCubit, SellerProfileState>(
                  builder: (context, state) {
                    if (state is SellerProfileLoadingProducts) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SellerProfileLoadedProducts) {
                      return ProductsTab(products: state.products);
                    } else if (state is SellerProfileError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                BlocBuilder<SellerProfileCubit, SellerProfileState>(
                  builder: (context, state) {
                    if (state is SellerProfileLoadingEvents) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SellerProfileLoadedEvents) {
                      return EventsTab(events: state.events);
                    } else if (state is SellerProfileError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                BlocBuilder<SellerProfileCubit, SellerProfileState>(
                  builder: (context, state) {
                    if (state is SellerProfileLoadingReviews) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SellerProfileLoadedReviews) {
                      return ReviewsTab(reviews: state.reviews);
                    } else if (state is SellerProfileError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
