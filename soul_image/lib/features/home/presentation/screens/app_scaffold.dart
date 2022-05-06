import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soul_image/core/config/routes/app_router.dart';
import 'package:soul_image/features/home/presentation/screens/home_page.dart';
import 'package:soul_image/features/home/presentation/screens/search_page.dart';
import 'package:soul_image/features/home/presentation/state_manager/bottom_nav_bar_provider.dart';
import 'package:soul_image/features/home/presentation/widgets/bottom_navigation_bar.dart';

class AppScaffold extends StatelessWidget {
  AppScaffold({Key? key}) : super(key: key);

  final List _screens = [
    const HomePage(
      key: PageStorageKey(1),
    ),
    const SearchPage(
      key: PageStorageKey(2),
    ),
    const ProfileScreen(),
  ];

  final List<IconData> items = [
    Icons.home_outlined,
    Icons.search_outlined,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavBarProvider = context.watch<BottomNavBarProvider>();

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: bottomNavBarProvider.pageIndex,
        items: items,
        onTap: (int index) {
          bottomNavBarProvider.pageIndex = index;
        },
        height: bottomNavBarProvider.isVisible ? 80 : 0,
        iconSize: 30,
      ),
      body: _screens[bottomNavBarProvider.pageIndex],
    );
  }
}
