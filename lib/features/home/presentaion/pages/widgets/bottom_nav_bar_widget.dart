// lib/presentation/widgets/bottom_nav_bar.dart

import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_app_bar_widget.dart';
import 'package:bingo/features/auth/login/presentation/forget_password/pages/forget_pass_screen.dart';
import 'package:bingo/features/auth/login/presentation/login/pages/login_screen.dart';
import 'package:bingo/features/home/presentaion/pages/home_screen.dart';
import 'package:bingo/features/profile/presentation/pages/profile_screen.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../profile/presentation/cubit/user_cubit/user_cubit.dart';
import '../add_product_screen.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    LoginScreen(),
    Container(), // Placeholder for Add button
    ForgetPassScreen(),
    BlocProvider(create: (_) => UserCubit(), child: const ProfileScreen()),
  ];

  void _onTap(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddProductPage()),
      );
    } else {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBarWidget(
        centerTitle: false,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: 12.w),
          child: CircleAvatar(
            child: ImageIcon(AssetImage(Assets.images.profile.path)),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {},
              child: ImageIcon(AssetImage(Assets.images.notification.path)),
            ),
          ),
          SizedBox(width: 7.w),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: _pages[_currentIndex],
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
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: SizedBox(
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(Icons.home, 'Home', 0),
                _navItem(Icons.language, 'Community', 1),
                const SizedBox(width: 48),
                _navItem(Icons.shopping_cart_outlined, 'Cart', 3),
                _navItem(Icons.person, 'Profile', 4),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onTap(2),
        shape: CircleBorder(),
        backgroundColor: lightTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isActive = _currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? lightTheme.primaryColor : Colors.grey),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? lightTheme.primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
