import 'package:flutter/material.dart';

abstract class AppTheme {
  static final theme = ThemeData(
    fontFamily: 'Tensor Sans',
    scaffoldBackgroundColor: AppColors.specialWhiteColor,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
        letterSpacing: 2,
      ),
      caption: TextStyle(
        color: Colors.grey,
        fontSize: 12,
        letterSpacing: 1,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 28,
    ),
  );
}

abstract class AppColors {
  static const Color specialWhiteColor = Color.fromRGBO(252, 252, 252, 1);
  static const Color bottomNavBarColor = Color.fromARGB(255, 16, 17, 16);
}
