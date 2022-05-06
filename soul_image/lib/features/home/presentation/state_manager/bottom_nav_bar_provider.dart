import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int _pageIndex = 0;

  bool _isVisible = true;

  bool _isScrollingDown = false;

  bool get isVisible => _isVisible;

  void hide() {
    if (!_isScrollingDown) {
      _isScrollingDown = true;
      _isVisible = false;
      notifyListeners();
    }
  }

  void show() {
    if (_isScrollingDown) {
      _isScrollingDown = false;
      _isVisible = true;
      notifyListeners();
    }
  }

  int get pageIndex => _pageIndex;

  set pageIndex(int newValue) {
    _pageIndex = newValue;
    notifyListeners();
  }
}
