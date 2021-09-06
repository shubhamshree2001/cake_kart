import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification/models/cart.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _cartList = [];

  double sum = 0;
  List<CartModel> get cartList {
    return _cartList;
  }

  void addToCartList(
      {String name, double price, int quantity, String weight, String unit}) {
    bool alreadyAdded = false;
    for (int i = 0; i < _cartList.length; ++i) {
      if (name == _cartList[i].name) {
        alreadyAdded = true;
        Get.snackbar(
          "Cart",
          "Item already in cart!",
          titleText: Text(
            "Cart",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          messageText: Text(
            "Item already in cart!",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
          isDismissible: true,
          backgroundColor: Colors.grey[900],
          colorText: Colors.black87,
          margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
          barBlur: 2,
          overlayBlur: 0,
        );
        break;
      }
    }
    if (!alreadyAdded) {
      _cartList.add(CartModel(
          name: name,
          price: price,
          quantity: quantity,
          weight: weight,
          unit: unit));
      Get.snackbar(
        "Cart",
        "Item added to cart successfully!",
        titleText: Text(
          "Cart",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        messageText: Text(
          "Item added to cart!",
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
        isDismissible: true,
        backgroundColor: Colors.grey[900],
        colorText: Colors.black87,
        margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
        barBlur: 2,
        overlayBlur: 0,
      );
    }
    notifyListeners();
    calculateTotalAmount();
  }

  void removeFromCartList(String name) {
    for (int i = 0; i < _cartList.length; ++i) {
      if (name == _cartList[i].name) {
        _cartList.removeAt(i);
        Get.snackbar(
          "Cart",
          "Item removed from cart!",
          titleText: Text(
            "Cart",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          messageText: Text(
            "$name removed from cart!",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
          isDismissible: true,
          // backgroundColor: Colors.yellow[900],
          colorText: Colors.black87,
          margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
          barBlur: 2,
          overlayBlur: 0,
        );
        break;
      }
    }
    notifyListeners();
  }

  void calculateTotalAmount() {
    sum = 0;
    for (int i = 0; i < _cartList.length; ++i) {
      sum = sum + (_cartList[i].price * _cartList[i].quantity);
    }
  }

  void increaseCount(String name) {
    for (int i = 0; i < _cartList.length; ++i) {
      if (name == _cartList[i].name) {
        ++_cartList[i].quantity;
      }
    }
    notifyListeners();
  }

  void decreaseCount(String name) {
    for (int i = 0; i < _cartList.length; ++i) {
      if (name == _cartList[i].name) {
        if (_cartList[i].quantity > 0) --_cartList[i].quantity;
        if (_cartList[i].quantity == 0) removeFromCartList(name);
      }
    }
    notifyListeners();
  }

  double getTotalAmount() {
    calculateTotalAmount();
    return sum;
  }

  int getQuantity(String name) {
    for (int i = 0; i < _cartList.length; ++i) {
      if (name == _cartList[i].name) {
        return _cartList[i].quantity;
      }
    }
    return 0;
  }

  bool showQuantityController(String name) {
    for (int i = 0; i < _cartList.length; ++i) {
      if (name == _cartList[i].name) {
        return true;
      }
    }
    return false;
  }

  void clearList() {
    _cartList.clear();
    notifyListeners();
  }
}
