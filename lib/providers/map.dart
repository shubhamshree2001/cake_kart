
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notification/providers/address.dart';
import 'package:provider/provider.dart';

class MapProvider with ChangeNotifier {

  Position _position ;

  Position get position {
    return _position;
  }

  set position(Position pos) {
    _position = pos;
    notifyListeners();
  }

  Map<String,dynamic> _address = {};

  Map<String,dynamic> get address {
    return _address ;
  }

  void setAddress({name, postalCode, administrativeArea, sublocality, locality}) {
    _address["name"] = name;
    _address["postalCode"] = postalCode;
    _address["sublocality"] = sublocality;
    _address["locality"] = locality;
    _address["administrativeArea"] = administrativeArea;
    notifyListeners();
  }

  bool checkIfNull() {
    if (_address != null)
      return false;
    else  
      return true;  
  }

}