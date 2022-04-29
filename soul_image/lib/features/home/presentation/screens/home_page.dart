import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soul_image/core/config/routes/app_router.dart';
import 'package:soul_image/features/home/presentation/state_manager/home_page_provider.dart';
import 'package:soul_image/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:soul_image/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:soul_image/features/home/presentation/widgets/home_page_grid.dart';
import 'package:soul_image/features/search_page/presentation/screens/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List _screens = [
    HomePageGridView(
      key: PageStorageKey(1),
    ),
    SearchPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeProvider>();

    return Scaffold(
      appBar: const CustomAppBar(height: 39),
      bottomNavigationBar: BottomNavBar(
        currentIndex: model.pageIndex,
        items: const [
          Icons.home_outlined,
          Icons.list_outlined,
          Icons.person_outline,
        ],
        onTap: (int index) {
          model.pageIndex = index;
        },
      ),
      body: _screens[model.pageIndex],
    );
  }
}
