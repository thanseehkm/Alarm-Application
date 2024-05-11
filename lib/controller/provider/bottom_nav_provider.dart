import 'package:flutter/material.dart';
import 'package:weather_app/model/bottom_nav_item.dart';

class BottomNavBarProvider extends ChangeNotifier {
  BottomNavItem _currentItem = BottomNavItem.weather;

  BottomNavItem get currentItem => _currentItem;

  void setCurrentItem(BottomNavItem item) {
    _currentItem = item;
    notifyListeners();
  }
}
