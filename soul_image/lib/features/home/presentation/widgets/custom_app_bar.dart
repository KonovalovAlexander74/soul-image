import 'package:flutter/material.dart';
import 'package:soul_image/core/config/themes/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title = '',
    this.height = 50,
    this.color = Colors.white,
    this.elevation = 0,
    this.actions,
  }) : super(key: key);

  final String title;
  final double height;
  final Color color;
  final double elevation;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions ?? [],
      iconTheme: const IconThemeData(color: AppColors.specialBlackColor),
      backgroundColor: color,
      toolbarHeight: height,
      elevation: elevation,
      title: Text(
        title,
        style: const TextStyle(
          color: Color.fromRGBO(32, 34, 36, 1),
          fontFamily: 'Tensor Sans',
          letterSpacing: 5,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
