import 'package:flutter/material.dart';

class SelectedDataMap extends ChangeNotifier {
  int _selectedWard = 1;
  int _selectedYear = 2022;
  String _selectedCategory = "Street Resurfacing";

  int get selectedWard => _selectedWard;
  int get selectedYear => _selectedYear;
  String get selectedCategory => _selectedCategory;

  void updateSelectedWard(int ward) {
    _selectedWard = ward;
    notifyListeners();
  }

  void updateSelectedYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
