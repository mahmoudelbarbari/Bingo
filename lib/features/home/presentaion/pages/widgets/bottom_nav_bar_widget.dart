import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_app_bar_widget.dart';
import 'package:bingo/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bingo/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:bingo/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:bingo/features/home/presentaion/pages/home_screen.dart';
import 'package:bingo/features/home/presentaion/pages/widgets/chat_bot_btn_widget.dart';
import 'package:bingo/features/profile/presentation/pages/profile_screen.dart';
import 'package:bingo/features/seller-order/presentation/pages/seller_order_pages.dart';
import 'package:bingo/features/seller_profile/presentation/pages/seller_profile_screen.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

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
  String _avatar = '';
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
      _isSeller
          ? _avatar = loggedData['shop']['avatar']
          : _avatar = loggedData['user']['avatar'];
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
      _isSeller
          ? SellerOrderPages()
          : BlocProvider(create: (_) => CartCubit(), child: const CartPage()),
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
            onTap: () {},
            child: CircleAvatar(
              child: (_avatar.startsWith('http') || _avatar.startsWith('https'))
                  ? Image.network(
                      _avatar,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image);
                      },
                    )
                  : Image.asset(
                      Assets.images.rectangle346246291.path,
                      fit: BoxFit.cover,
                    ),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTap,
        selectedItemColor: lightTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: loc.home),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: loc.community,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _isSeller
                  ? Icons.receipt_long_outlined
                  : Icons.shopping_cart_outlined,
            ),
            label: _isSeller ? loc.order : loc.cart,
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: loc.profile),
        ],
      ),
      floatingActionButton: _isSeller
          ? ExpandableFab(
              type: ExpandableFabType.fan,
              pos: ExpandableFabPos.center,
              distance: 80.0,
              openButtonBuilder: RotateFloatingActionButtonBuilder(
                child: const Icon(Icons.add),
                fabSize: ExpandableFabSize.regular,
                backgroundColor: lightTheme.primaryColor,
                shape: const CircleBorder(),
              ),
              children: [
                FloatingActionButton.small(
                  tooltip: loc.createDiscount,
                  heroTag: 'discount',
                  onPressed: () =>
                      Navigator.pushNamed(context, '/discountCodes'),
                  backgroundColor: Colors.orange,
                  child: const Icon(Icons.discount),
                ),
                FloatingActionButton.small(
                  tooltip: loc.addProduct,
                  heroTag: 'product',
                  onPressed: () => Navigator.pushNamed(context, '/add-product'),
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add_task),
                ),
                FloatingActionButton.small(
                  tooltip: loc.createEvent,
                  heroTag: 'event',
                  onPressed: () => Navigator.pushNamed(context, '/add-event'),
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.event),
                ),
              ],
            )
          : null,
      floatingActionButtonLocation: _isSeller ? ExpandableFab.location : null,
      body: Builder(
        builder: (context) => Stack(
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
      ),
    );
  }
}
