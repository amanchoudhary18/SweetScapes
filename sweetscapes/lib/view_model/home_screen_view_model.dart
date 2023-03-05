import 'package:flutter/material.dart';

class HomeScreenViewModel with ChangeNotifier {
  int _currentScreenIndex = 0;
  int get currentScreenIndex => _currentScreenIndex;

  updateIndex(int value) {
    _currentScreenIndex = value;
    notifyListeners();
  }
}
