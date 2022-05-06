import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soul_image/core/config/routes/app_router.dart';
import 'package:soul_image/core/config/themes/app_theme.dart';
import 'package:soul_image/features/home/presentation/state_manager/bottom_nav_bar_provider.dart';
import 'package:soul_image/features/home/presentation/state_manager/home_page_provider.dart';
import 'package:soul_image/features/home/presentation/state_manager/search_page_provider.dart';
import 'package:soul_image/locator_service.dart';

class SoulImageApp extends StatelessWidget {
  const SoulImageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => locatorService<HomeProvider>(),
        ),
        ChangeNotifierProvider<BottomNavBarProvider>(
          create: (context) => locatorService<BottomNavBarProvider>(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => locatorService<SearchProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouteNames.home,
        routes: AppRouter.routes,
      ),
    );
  }
}
