import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification/providers/address.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

class CustomCheckOutPage extends StatefulWidget {
  @override
  _CustomCheckOutPageState createState() => _CustomCheckOutPageState();
}

class _CustomCheckOutPageState extends State<CustomCheckOutPage> {
  void onPLayAudio() async {
    AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
      Audio("assets/audio/complete.mp3"),
    );
  }

  Razorpay _razorpay;
  Map data = Get.arguments;
  List addOns = Get.arguments["addOns"];
  int addOnsSum = 0;
  DateTime now = DateTime.now();
  void addOnSum() {
    for (var i = 0; i < addOns.length; ++i) {
      setState(() {
        addOnsSum = addOnsSum + int.parse(addOns[i]["price"]);
      });
    }
    print(addOnsSum);
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

        FirebaseFirestore.instance.collection("walkInOrders").doc().set({
          "Order Number": number,
          "UID": uId,
          "name": _addressProvider.name,
          "address": _addressProvider.addressLine1 +
              ',' +
              _addressProvider.addressLine2 +
              ',' +
              _addressProvider.addressLine3,
          "order": {
            "Cake Name": data["name"],
            "unit": data["unit"],
            "weight": data["weight"],
            "Delivery date": data["date"],
            "Delivery time": data["time"],
            "quantity": data["quantity"]
          },
          "amount":
              ((data["quantity"] * (int.parse(data["pricePerQty"]["price"]))) +
                      addOnsSum)
                  .toString(),
          "time": DateTime.now().toString(),
          "image": "gs://carnival-c4226.appspot.com/walk_in/$number",
          "PricePerQuantiy": {
            "name": data["pricePerQty"]["name"],
            "price": data["pricePerQty"]["price"]
          },
          "addOns": addOns.map((e) {
            return {"name": e["name"], "price": e["price"]};
          }).toList(),
          "date": {
            "day": DateTime.now().day,
            "month": DateTime.now().month,
            "year": DateTime.now().year,
          },
        }).then((value) {
          onPLayAudio();
          HapticFeedback.vibrate();
          StorageReference firebaseStorageRef =
              FirebaseStorage.instance.ref().child("walk_in/$number");
          StorageUploadTask uploadTask =
              firebaseStorageRef.putFile(data["imageUrl"]);
          Future<StorageTaskSnapshot> taskSnapshot = uploadTask.onComplete;
          taskSnapshot.then((value) {
            Get.offAndToNamed("/WalkInOrderComplete");
          });
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
      'amount':
          ((data["quantity"] * (int.parse(data["pricePerQty"]["price"]))) +
                  addOnsSum) *
              100,
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
  @override
  void initState() {
    print(data['message']);
    super.initState();
    addOnSum();
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
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
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
          Get.offAndToNamed("/premium");
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
        _buildOrderDetails(context),
      ],
    ));
  }

  Widget _buildOrderDetails(BuildContext context) {
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

    final _maargin = _addressProvider.margin * 0.01;
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Cake Name",
                              style: GoogleFonts.roboto(),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              data["name"],
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Cake Weight",
                              style: GoogleFonts.roboto(),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              data["weight"],
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Weight Unit",
                              style: GoogleFonts.roboto(),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              data["unit"],
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Quantity",
                              style: GoogleFonts.roboto(),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              data["quantity"].toString(),
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Date",
                              style: GoogleFonts.roboto(),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              data["date"],
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Time",
                              style: GoogleFonts.roboto(),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              data["time"],
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Price Per Qauntity",
                              style: GoogleFonts.roboto(),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              data["pricePerQty"]["name"],
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Add Ons",
                              style: GoogleFonts.roboto(),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              "Price",
                              textAlign: TextAlign.end,
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        Column(
                          children: addOns.map((e) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e["name"],
                                  style: GoogleFonts.roboto(
                                      color: Colors.grey[600]),
                                ),
                                Text(
                                  e["price"],
                                  style: GoogleFonts.roboto(
                                      color: Colors.grey[600]),
                                )
                              ],
                            );
                          }).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Message",
                              style: GoogleFonts.roboto(),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              data["message"],
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
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
                    (data["quantity"] *
                                (int.parse(data["pricePerQty"]["price"])) +
                            addOnsSum)
                        .toString(),
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
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
                    ((data["quantity"] *
                                    (int.parse(data["pricePerQty"]["price"])) +
                                addOnsSum) *
                            _maargin)
                        .toString(),
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
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
                    ((data["quantity"] *
                                    (int.parse(data["pricePerQty"]["price"])) +
                                addOnsSum) +
                            (data["quantity"] *
                                        (int.parse(
                                            data["pricePerQty"]["price"])) +
                                    addOnsSum) *
                                _maargin)
                        .toString(),
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
              Get.toNamed('/addressDetailsCustom');
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
          _buildPayPalButton(context),
          // _buildTextArea(context),
          _buildCODButton(context),
        ],
      ),
    );
  }

  Widget _buildPayPalButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 15, top: 5),
      child: Material(
        color: Colors.yellow[900],
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Future.delayed(Duration(milliseconds: 250), () {
              openCheckout(1000);
            });
          },
          child: Container(
            padding: EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone_iphone,
                  size: 28,
                  color: Colors.white,
                ),
                Expanded(
                  child: Text(
                    "Online Payment",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCODButton(BuildContext context) {
    // String formattedDate = DateFormat('kkmmssd').format(now);
    // String ordernumber = 'CO' + formattedDate.toString();
    return Container(
      decoration: BoxDecoration(
          color: Colors.yellow[900], borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 5),
      child: Material(
        color: Colors.yellow[900],
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            print('CO' +
                DateFormat('kkmmssdSSS').format(DateTime.now()).toString());
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

            final _margin = _addressProvider.margin * 0.01;

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
                "order number": 'CO' +
                    DateFormat('kkmmssdSSS').format(DateTime.now()).toString()
              }).then((value) {
                print("====================================");

                FirebaseFirestore.instance
                    .collection("walkInOrders")
                    .doc()
                    .set({
                  "status": 'Pending',
                  "Order Number": 'CO' +
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
                  "order": {
                    "Cake Name": data["name"],
                    "unit": data["unit"],
                    "weight": data["weight"],
                    "Delivery date": data["date"],
                    "Delivery time": data["time"],
                    "quantity": data["quantity"],
                    "message": data['message'] ?? ''
                  },
                  "amount": (((data["quantity"] *
                                  (int.parse(data["pricePerQty"]["price"]))) +
                              addOnsSum) +
                          ((data["quantity"] *
                                      (int.parse(
                                          data["pricePerQty"]["price"]))) +
                                  addOnsSum) *
                              (_margin))
                      .toString(),
                  "time": DateTime.now(),
                  "image":
                      "gs://carnival-c4226.appspot.com/walk_in/${'RE' + DateFormat('kkmmssdSSS').format(DateTime.now()).toString()}",
                  "Price Per Quantiy": {
                    "name": data["pricePerQty"]["name"],
                    "price": data["pricePerQty"]["price"]
                  },
                  "addOns": addOns.map((e) {
                    return {"name": e["name"], "price": e["price"]};
                  }).toList(),
                  "date": {
                    "day": DateTime.now().day,
                    "month": DateTime.now().month,
                    "year": DateTime.now().year,
                  },
                }).then((value) {
                  onPLayAudio();
                  HapticFeedback.vibrate();
                  StorageReference firebaseStorageRef = FirebaseStorage.instance
                      .ref()
                      .child(
                          "walk_in/${'RE' + DateFormat('kkmmssdSSS').format(DateTime.now()).toString()}");
                  // firebaseStorageRef.getDownloadURL().then(
                  //       (val) => {
                  //         print(val),
                  //         FirebaseFirestore.instance
                  //             .collection("walkInOrders")
                  //             .doc()
                  //             .set({
                  //           'image_path': val,
                  //         }),
                  //       },
                  //     );

                  StorageUploadTask uploadTask =
                      firebaseStorageRef.putFile(data["imageUrl"]);

                  Future<StorageTaskSnapshot> taskSnapshot =
                      uploadTask.onComplete;

                  taskSnapshot.then((value) {
                    Get.offAndToNamed("/WalkInOrderComplete");
                  });
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
                    "Cash on Delivery",
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
