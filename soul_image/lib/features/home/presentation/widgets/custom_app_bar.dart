import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.height}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: height,
      title: const Text(
        'SOUL IMAGE',
        style: TextStyle(
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
