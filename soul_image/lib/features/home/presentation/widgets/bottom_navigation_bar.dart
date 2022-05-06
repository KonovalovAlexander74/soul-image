import 'package:flutter/material.dart';
import 'package:soul_image/core/config/themes/app_theme.dart';

enum Screens { home, search }

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.items,
    required this.onTap,
    this.currentIndex = 0,
    this.height = 80,
    this.backgroundColor = AppColors.specialBlackColor,
    this.iconSize = 28.0,
    this.selectedItemColor = AppColors.specialWhiteColor,
    this.unselectedItemColor = Colors.grey,
    this.borderRadius = 10,
  }) : super(key: key);

  final List<IconData> items;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final double height;
  final Color backgroundColor;
  final double iconSize;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: backgroundColor,
            spreadRadius: 2,
            blurRadius: 5,
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.map((icon) {
            final index = items.indexOf(icon);
            final isSelected = index == currentIndex;
            return GestureDetector(
              onTap: () {
                if (!isSelected) {
                  onTap(index);
                }
              },
              child: BottomNavBarItem(
                icon,
                size: iconSize,
                color: isSelected ? selectedItemColor : unselectedItemColor,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem(
    this.icon, {
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
