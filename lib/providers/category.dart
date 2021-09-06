import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {

  List<Map<String,dynamic>> category = [] ;

  List<Map<String,dynamic>> categoryList() {
    return category;
  }

  void addCategory(List categoryList) {
    category = categoryList;
    notifyListeners();
  }

  void showList() {
    print(category);
  }
}