import 'package:flutter/cupertino.dart';

class BottomBarProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setTabIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
