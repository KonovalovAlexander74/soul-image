import 'package:flutter/material.dart';
import 'package:soul_image/features/home/presentation/screens/app_scaffold.dart';
import 'package:soul_image/features/home/presentation/screens/search_page.dart';

abstract class AppRouteNames {
  static const home = '/home';
  static const search = '/search';
  static const profile = '/profile';
}

abstract class AppRouter {
  static final Map<String, Widget Function(BuildContext)> routes = {
    AppRouteNames.home: (context) => AppScaffold(),
    AppRouteNames.search: (context) => const SearchPage(),
    AppRouteNames.profile: (context) => const ProfileScreen(),
  };
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
