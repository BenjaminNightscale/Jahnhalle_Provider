import 'package:flutter/material.dart';

class BottomBarProvider with ChangeNotifier {
  int initialSelectedIndex = 0;
  int get selectedIndex => initialSelectedIndex;
  void onItemTapped(int index) {
    initialSelectedIndex = index;
    switch (index) {
      case 0:
        print("Home tapped");
        changeTable(true);
        changeTableTitle("Tisch");
        break;
      case 1:
        // Navigate to Edit Screen
        print("Edit tapped");
        break;
      case 2:
        // Navigate to Calendar Screen
        print("Calendar tapped");
        break;
      case 3:
        // Navigate to Events Screen
        print("Events tapped");
        break;
      case 4:
        // Navigate to Table Screen
        print("Table tapped");
        break;
      case 5:
        // Navigate to Statistics Screen
        print("Statistics tapped");
        break;
      case 6:
        // Navigate to Food Screen
        print("Food tapped");
        break;
    }
    notifyListeners();
  }

  String _homeTitle = "Home";
  String get homeTitle => _homeTitle;
  void changeTitle(String value) {
    _homeTitle = value;
    notifyListeners();
  }

  bool _isHome = true;
  bool get isHome => _isHome;
  void changeHomePage(bool value) {
    _isHome = value;
    notifyListeners();
  }

  String _tableTitle = "Tische";
  String get tableTitle => _tableTitle;
  void changeTableTitle(String value) {
    _tableTitle = value;
    notifyListeners();
  }

  bool _isTablePage = true;
  bool get isTablePage => _isTablePage;
  void changeTable(bool value) {
    _isTablePage = value;
    notifyListeners();
  }
}
