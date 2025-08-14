import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_app_bar_widget.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bingo/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:bingo/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:bingo/features/home/presentaion/pages/home_screen.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/chat_bot_btn_widget.dart';
import 'package:bingo/features/profile/presentation/pages/profile_screen.dart';
import 'package:bingo/features/seller_profile/presentation/pages/seller_profile_screen.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/token_storage.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../cart/presentation/pages/cart_page.dart';
import '../../../../profile/presentation/cubit/user_cubit/user_cubit.dart';
import 'action_btn_top_bar_widget.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _currentIndex = 0;
  bool _isSeller = false;
  String _sellerId = '';
  String _sellerName = 'test test';
  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    final isSeller = await TokenStorage.isSeller();
    final sellerId = await TokenStorage.getSellerId();
    final loggedData = await TokenStorage.getLoggedUserData();

    setState(() {
      _isSeller = isSeller;
      _sellerId = sellerId ?? '';
      _sellerName = loggedData!['name'];
    });
  }

  void _onTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final List<Widget> _pages = [
      _isSeller
          ? BlocProvider(
              create: (_) => DashboardCubit(),
              child: DashboardPage(),
            )
          : HomeScreen(),
      SafeArea(child: Text('data,')),
      BlocProvider(create: (_) => CartCubit(), child: const CartPage()),
      _isSeller
          ? SellerProfileScreen(sellerId: _sellerId)
          : BlocProvider(
              create: (_) => UserCubit(),
              child: const ProfileScreen(),
            ),
    ];
    return Scaffold(
      appBar: CustomeAppBarWidget(
        centerTitle: false,
        title: '${loc.welcome} , $_sellerName',
        subTitle: _isSeller
            ? loc.turnYourPassionIntoProfit
            : loc.createYourDreamsWithJoy,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: 12.w),
          child: InkWell(
            onTap: () async {
              final sellerId = await TokenStorage.getSellerId();
              if (sellerId != null) {
                Navigator.pushNamed(
                  context,
                  '/seller-profile',
                  arguments: sellerId,
                );
              } else {
                showAppSnackBar(
                  context,
                  'Seller profile not available',
                  isError: true,
                );
              }
            },
            child: CircleAvatar(
              child: ImageIcon(AssetImage(Assets.images.profile.path)),
            ),
          ),
        ),
        actions: [
          ActionBtnTopBarWidget(icon: Assets.images.chat.path, onTap: () {}),
          SizedBox(width: 12.w),
          ActionBtnTopBarWidget(
            icon: Assets.images.notification.path,
            onTap: () {},
          ),
          SizedBox(width: 7.w),
        ],
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: SizedBox(
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              child: SizedBox(
                height: 60.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(Icons.home, 0),
                    _navItem(Icons.language, 1),
                    if (_isSeller) const SizedBox(width: 48),
                    _navItem(Icons.shopping_cart_outlined, 2),
                    _navItem(Icons.person, 3),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: _isSeller
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-product');
              },
              shape: CircleBorder(),
              backgroundColor: lightTheme.primaryColor,
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: _isSeller
          ? FloatingActionButtonLocation.centerDocked
          : null,
      body: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            child: ChatBotBtnWidget(
              onPressed: () => Navigator.pushNamed(context, "/chatBot"),
              iconAssetPath: Assets.images.chatbot.path,
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    final isActive = _currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? lightTheme.primaryColor : Colors.grey),
          ],
        ),
      ),
    );
  }
}
