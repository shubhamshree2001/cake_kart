import 'package:flutter/material.dart';

class DryProductsCategoriesProvider with ChangeNotifier {
  List _categoryName = [];

  List categoryName() {
    return _categoryName;
  }

  int categoryLength() {
    return _categoryName.length;
  }

  void loadCategoryNames(data) {
    _categoryName.add(data);
    notifyListeners();
  }

  void showData() {
    print(_categoryName);
  }

  void clearList() {
    _categoryName.clear();
    notifyListeners();
  }
}
