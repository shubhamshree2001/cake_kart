import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
  String _name = "";
  String _contact = "";
  String _email = "";
  int _margin = 0;

  String _addressLine1 = "House No, Block No, Street Name";
  String _addressLine2 = "Road Name, Landmark";
  String _addressLine3 = "District, City";

  String get name {
    return _name;
  }

  String get contact {
    return _contact;
  }

  String get email {
    return _email;
  }

  int get margin {
    return _margin;
  }

  String get addressLine1 {
    return _addressLine1;
  }

  String get addressLine2 {
    return _addressLine2;
  }

  String get addressLine3 {
    return _addressLine3;
  }

  set name(String name) {
    this._name = name;
    notifyListeners();
  }

  set margin(int margin) {
    this._margin = margin;
    notifyListeners();
  }

  set email(String email) {
    this._email = email;
    notifyListeners();
  }

  set contact(String contact) {
    this._contact = contact;
    notifyListeners();
  }

  set addressLine1(String address) {
    this._addressLine1 = address;
    notifyListeners();
  }

  set addressLine2(String address) {
    this._addressLine2 = address;
    notifyListeners();
  }

  set addressLine3(String address) {
    this._addressLine3 = address;
    notifyListeners();
  }
}
