import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification/providers/address.dart';
import 'package:notification/providers/cart.dart';
import 'package:notification/providers/map.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Razorpay _razorpay;
  DateTime selectedDate = DateTime.now();
  String formattedDate;
  DateTime now = DateTime.now();

  void onPLayAudio() async {
    AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
      Audio("assets/audio/complete.mp3"),
    );
  }

  void handlerPaymentSuccess(_) {
    Get.snackbar(
      "Payment",
      "Transaction Successful!",
      titleText: Text(
        "Payment",
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
      ),
      messageText: Text(
        "Transaction Successful!",
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 12,
        ),
      ),
      isDismissible: true,
      backgroundColor: Colors.grey[900],
      colorText: Colors.black87,
      margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
      barBlur: 2,
      overlayBlur: 0,
    );
    final user = FirebaseAuth.instance.currentUser;
    String uId = user.uid;
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final _cartProvider = Provider.of<CartProvider>(context, listen: false);
    final _subTotal = _cartProvider.getTotalAmount().toStringAsFixed(2);
    final _cartList = _cartProvider.cartList;
    // ignore: deprecated_member_use
    Firestore.instance
        .collection("/Order Number")
        .doc("order number")
        .get()
        .then((value) {
      print("=========================");
      int number = value.data()["order number"];
      ++number;
      print(number);
      // ignore: deprecated_member_use
      Firestore.instance
          .collection("/Order Number")
          .doc("order number")
          .set({"order number": number}).then((value) {
        print("====================================");
        FirebaseFirestore.instance.collection("orders").doc().set({
          "Order Number": number,
          "UID": uId,
          "name": _addressProvider.name,
          "address": _addressProvider.addressLine1 +
              ',' +
              _addressProvider.addressLine2 +
              ',' +
              _addressProvider.addressLine3,
          "orders": _cartList.map((e) => e.name.toString()).toList(),
          "order_quantity": _cartList.map((e) => e.quantity).toList(),
          "amount": _subTotal,
          "date": {
            "day": DateTime.now().day,
            "month": DateTime.now().month,
            "year": DateTime.now().year,
          },
          "time": DateTime.now().toString(),
        }).then((value) {
          onPLayAudio();
          HapticFeedback.vibrate();
          _cartProvider.clearList();
          Get.offAndToNamed("/orderComplete");
        }).catchError((err) {
          printError(info: err);
        });
      });
    });
  }

  void handlerPaymentError(_) {
    Get.snackbar(
      "Payment",
      "Transaction Unsuccessful!",
      titleText: Text(
        "Payment",
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
      ),
      messageText: Text(
        "Transaction Unsuccessful!",
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 12,
        ),
      ),
      isDismissible: true,
      backgroundColor: Colors.grey[900],
      colorText: Colors.black87,
      margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
      barBlur: 2,
      overlayBlur: 0,
    );
  }

  void handlerExternalWallet(_) {
    Get.snackbar(
      "Checkout",
      "External Wallet!",
      titleText: Text(
        "Checkout",
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
      ),
      messageText: Text(
        "External Wallet!",
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 12,
        ),
      ),
      isDismissible: true,
      backgroundColor: Colors.grey[900],
      colorText: Colors.black87,
      margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
      barBlur: 2,
      overlayBlur: 0,
    );
  }

  void openCheckout(double amount) {
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final String contact = _addressProvider.contact;
    final String email = _addressProvider.email;
    var options = {
      'key': 'rzp_test_YD0jLZRygOIv0s',
      'amount': amount * 100,
      'name': 'Cake Carnival',
      'description': 'This amount will be paid to Cake Carnival!',
      'prefill': {'contact': contact, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.white),
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Checkout",
        style: GoogleFonts.roboto(fontSize: 17),
      ),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 16,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: _buildColumn(context),
      ),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      children: [_buildHeader(context), _buildFooter(context)],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        _buildAddressDetails(context),
        _buildDateSelector(context),
        _buildOrderDetails(context),
      ],
    ));
  }

  Widget _buildDateSelector(BuildContext context) {
    formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), // Refer step 1
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
          print(formattedDate);
        });
      print(formattedDate);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "${selectedDate.toLocal()}".split(' ')[0],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10.0,
        ),
        RaisedButton(
          onPressed: () => _selectDate(context), // Refer step 3
          child: Text(
            'Select Delivery date',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          color: Colors.greenAccent,
        ),
      ],
    );
  }

  Widget _buildAddressDetails(BuildContext context) {
    final _addressProvider = Provider.of<AddressProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(top: 5),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.location_on,
                color: Colors.red[700],
              )),
          Container(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              "${_addressProvider.addressLine1}",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              "${_addressProvider.addressLine2}",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              "${_addressProvider.addressLine3}",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed('/addressDetails');
            },
            child: Container(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                "Change delivery address",
                style: TextStyle(color: Colors.yellow[900], fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    final _subTotal = _cartProvider.getTotalAmount().toStringAsFixed(2);
    final _cartList = _cartProvider.cartList;
    final _addressProvider = Provider.of<AddressProvider>(context);
    final _totalAmount = _cartProvider.getTotalAmount();
    final _margin = _addressProvider.margin * 0.01;
    final _discount = _totalAmount * _margin;
    final _finalAmount = _totalAmount + _discount;
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(
            color: Colors.grey[100],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
              child: Text(
                "Order Details",
                style: GoogleFonts.roboto(
                    color: Colors.grey[800],
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(18, 0, 18, 18),
                padding: EdgeInsets.all(10),
                color: Colors.grey[100],
                child: ListView.builder(
                    itemCount: _cartList.length,
                    itemBuilder: (_, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${_cartList[index].name}",
                            style: GoogleFonts.roboto(),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            "${(_cartList[index].quantity * _cartList[index].price).toStringAsFixed(2)}",
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            "    x${_cartList[index].quantity}",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      );
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
              margin: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Total Items",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "${_cartList.length}",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
              margin: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Margin",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "${_addressProvider.margin}%",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
              margin: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Sub total",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "$_subTotal",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
              margin: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Margin Amount",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "${(_finalAmount - double.parse(_subTotal)).toString()}",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(18, 0, 18, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Amount to Pay",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "$_finalAmount",
                    style: TextStyle(
                        color: Colors.lightGreenAccent[700],
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildPayPalButton(context),
          _buildCODButton(context),
        ],
      ),
    );
  }

  // Widget _buildPayPalButton(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.grey[100],
  //       borderRadius: BorderRadius.circular(12)
  //     ),
  //     margin: EdgeInsets.only(bottom: 15,top: 5),
  //     child: Material(
  //       color: Colors.yellow[900],
  //       borderRadius: BorderRadius.circular(12),
  //       child: InkWell(
  //         onTap: (){
  //           Future.delayed(Duration(milliseconds: 250),() {
  //             final _cartProvider = Provider.of<CartProvider>(context, listen: false);
  //             double totalAmount = _cartProvider.getTotalAmount();
  //             openCheckout(totalAmount);
  //           });
  //         },
  //         child: Container(
  //           padding: EdgeInsets.all(14),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Icon(Icons.phone_iphone,size: 28,color: Colors.white,),
  //               Expanded(
  //                 child: Text(
  //                   "Online Payment",
  //                   textAlign: TextAlign.center,
  //                   style: GoogleFonts.roboto(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w600,
  //                     color: Colors.white
  //                   ),
  //                 ),
  //               ),
  //               Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,)
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCODButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.yellow[900], borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 5),
      child: Material(
        color: Colors.yellow[900],
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Get.snackbar(
              "Payment",
              "Transaction Successful!",
              titleText: Text(
                "Status",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              messageText: Text(
                "Order Successfully Placed!",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              isDismissible: true,
              backgroundColor: Colors.grey[900],
              colorText: Colors.black87,
              margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
              barBlur: 2,
              overlayBlur: 0,
            );
            final user = FirebaseAuth.instance.currentUser;
            String uId = user.uid;
            final _addressProvider =
                Provider.of<AddressProvider>(context, listen: false);
            final _cartProvider =
                Provider.of<CartProvider>(context, listen: false);
            final _subTotal = _cartProvider.getTotalAmount().toStringAsFixed(2);
            final _cartList = _cartProvider.cartList;

            final _totalAmount = _cartProvider.getTotalAmount();
            final _margin = _addressProvider.margin * 0.01;
            final _discount = _totalAmount * _margin;
            final _finalAmount = _totalAmount + _discount;
            final _mapProvider =
                Provider.of<MapProvider>(context, listen: false);
            final map = _mapProvider.address;
            // ignore: deprecated_member_use
            Firestore.instance
                .collection("/Order Number")
                .doc("order number")
                .get()
                .then((value) {
              print("=========================");
              // int number = value.data()["order number"];
              // ++number;
              // print(number);
              // ignore: deprecated_member_use
              Firestore.instance
                  .collection("/Order Number")
                  .doc("order number")
                  .set({
                "order number": 'RE' +
                    DateFormat('kkmmssdSSS').format(DateTime.now()).toString()
              }).then((value) {
                print("====================================");
                FirebaseFirestore.instance.collection("orders").doc().set({
                  "Order Number": 'RE' +
                      DateFormat('kkmmssdSSS')
                          .format(DateTime.now())
                          .toString(),
                  "UID": uId,
                  "name": _addressProvider.name,
                  "address": _addressProvider.addressLine1 +
                      ',' +
                      _addressProvider.addressLine2 +
                      ',' +
                      _addressProvider.addressLine3,
                  "orders": _cartList
                      .map((e) => {
                            'name': e.name.toString(),
                            'weight': e.weight.toString(),
                            'unit': e.unit.toString(),
                            'amount': e.price.toString()
                          })
                      .toList(),
                  "order_quantity": _cartList.map((e) => e.quantity).toList(),
                  "amount": _finalAmount.toString(),
                  "time": DateTime.now(),
                  "date": {
                    "day": DateTime.now().day,
                    "month": DateTime.now().month,
                    "year": DateTime.now().year,
                  },
                  "delivery_date": formattedDate,
                  'status': 'Pending',
                }).then((value) {
                  onPLayAudio();
                  HapticFeedback.vibrate();
                  _cartProvider.clearList();
                  Get.offAndToNamed("/orderComplete");
                }).catchError((err) {
                  printError(info: err);
                });
              });
            });
          },
          child: Container(
            padding: EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.monetization_on,
                  size: 28,
                  color: Colors.white,
                ),
                Expanded(
                  child: Text(
                    "Confirm Order",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
