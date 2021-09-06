import 'package:flutter/material.dart';

class CategoriesProvider with ChangeNotifier {
  List _categoryName = [];
  List _categoryIDName = [];

  List categoryName() {
    return _categoryName;
  }

  List categoryID() {
    return _categoryIDName;
  }

  int categoryLength() {
    return _categoryName.length;
  }

  int categoryIDLength() {
    return _categoryIDName.length;
  }

  void loadCategoryNames(data) {
    _categoryName.add(data);
    notifyListeners();
  }

  void loadCategoryIDNames(data) {
    _categoryIDName.add(data);
    notifyListeners();
  }

  void showData() {
    print(_categoryName);
  }

  void showIDData() {
    print(_categoryIDName);
  }

  void clearList() {
    _categoryName.clear();
    notifyListeners();
  }

  void clearIDList() {
    _categoryIDName.clear();
    notifyListeners();
  }
}
