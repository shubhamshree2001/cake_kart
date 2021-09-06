import 'package:flutter/material.dart';

class ImagesCategoriesProvider with ChangeNotifier {
  List _ImageCategoryName = [];
  List _ImageCategoryIDName = [];

  List categoryName() {
    return _ImageCategoryName;
  }

  List categoryID() {
    return _ImageCategoryIDName;
  }

  int categoryLength() {
    return _ImageCategoryName.length;
  }

  int categoryIDLength() {
    return _ImageCategoryIDName.length;
  }

  void loadCategoryNames(data) {
    _ImageCategoryName.add(data);
    notifyListeners();
  }

  void loadCategoryIDNames(data) {
    _ImageCategoryIDName.add(data);
    notifyListeners();
  }

  void showData() {
    print(_ImageCategoryName);
  }

  void showIDData() {
    print(_ImageCategoryIDName);
  }

  void clearList() {
    _ImageCategoryName.clear();
    notifyListeners();
  }

  void clearIDList() {
    _ImageCategoryIDName.clear();
    notifyListeners();
  }
}
