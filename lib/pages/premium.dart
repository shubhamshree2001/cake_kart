import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PremiumPage extends StatefulWidget {
  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  void loadData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("walk_in");
    collectionReference.get().then((data) {
      for (int i = 0; i < data.docs.length; ++i) {
        print(data.docs[i]["price"]);
        pricePerQuantity
            .add({"name": data.docs[i].id, "price": data.docs[i]["price"]});
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  bool isLoading = true;

  TextEditingController _nameController;
  TextEditingController _weightController;
  TextEditingController messageController = new TextEditingController();
  List pricePerQuantity = [];
  List addOns = [];

  String price;
  Map pricePerQty;
  String message = '';
  String name;
  String weight;
  String addOnName;
  String addOnPrice;
  String unit;
  int quantity = 1;
  DateTime dateTime;
  TimeOfDay time;
  File file;

  void pickImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      file = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.grey[900],
      centerTitle: true,
      title: Text(
        "Custom Cake",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 16,
          color: Colors.white,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              )),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _productName(context),
                _cakeWeight(context),
                _cakeWeightUnit(context),
                _cakeQuantity(context),
                _cakePricePerQty(context),
                _addOns(context),
                _cakeDeliveryDate(context),
                _imageDisplayer(context),
                _buildTextArea(context),
                _checkoutButton(context),
              ],
            ),
          ),
        ));
  }

  Widget _productName(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: TextFormField(
        controller: _nameController,
        onChanged: (value) {
          setState(() {
            name = value;
          });
        },
        style: TextStyle(
          fontSize: 18,
        ),
        cursorColor: Colors.grey[800],
        cursorRadius: Radius.circular(18),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            hintText: "Enter Cake Name",
            hintStyle: TextStyle(
              fontSize: 16,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.grey[800],
            ))),
      ),
    );
  }

  Widget _cakeWeight(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: TextFormField(
        controller: _weightController,
        onChanged: (value) {
          setState(() {
            weight = value;
          });
        },
        style: TextStyle(
          fontSize: 18,
        ),
        cursorColor: Colors.grey[800],
        cursorRadius: Radius.circular(18),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            hintText: "Enter Weight",
            hintStyle: TextStyle(
              fontSize: 16,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.grey,
            ))),
      ),
    );
  }

  Widget _cakeWeightUnit(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
            child: Text(
              "Cake Unit",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: const Text('Grams'),
            leading: Radio(
              value: "gram",
              groupValue: unit,
              onChanged: (value) {
                setState(() {
                  unit = value;
                });
              },
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: const Text('Kilograms'),
            leading: Radio(
              value: "Kg",
              groupValue: unit,
              onChanged: (value) {
                setState(() {
                  unit = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _cakePricePerQty(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
            child: Text(
              "Price Per Quantity",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          isLoading
              ? Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))
              : Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      elevation: 1,
                      hint: Text("Select Price"),
                      value: pricePerQty,
                      onChanged: (newValue) {
                        print(newValue);
                        setState(() {
                          pricePerQty = newValue;
                        });
                      },
                      items: pricePerQuantity.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item["name"]),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[850],
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.fromLTRB(8, 4, 10, 4),
                                  child: Text(
                                    "Rs " + item["price"],
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget _addOns(context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
            child: Text(
              "Cake Add Ons",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 6, 18, 18),
            child: TextFormField(
              controller: _nameController,
              onChanged: (value) {
                setState(() {
                  addOnName = value;
                });
              },
              style: TextStyle(
                fontSize: 18,
              ),
              cursorColor: Colors.grey[800],
              cursorRadius: Radius.circular(18),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: "Enter Add On Name",
                  hintStyle: TextStyle(
                    fontSize: 16,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey[800],
                  ))),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(18, 0, 18, 18),
            child: TextFormField(
              controller: _nameController,
              onChanged: (value) {
                setState(() {
                  addOnPrice = value;
                });
              },
              onFieldSubmitted: (_) {
                setState(() {
                  addOns.add({"name": addOnName, "price": addOnPrice});
                });
              },
              style: TextStyle(
                fontSize: 18,
              ),
              cursorColor: Colors.grey[800],
              cursorRadius: Radius.circular(18),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: "Enter Add On Price",
                  hintStyle: TextStyle(
                    fontSize: 16,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey[800],
                  ))),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(18, 8, 18, 26),
            child: addOns.length == 0
                ? Center(child: Text("No Add Ons Yet"))
                : Column(
                    children: addOns.map((e) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(e["name"]), Text("Rs  " + e["price"])],
                      );
                    }).toList(),
                  ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (addOnName != null && addOnPrice != null) {
                  setState(() {
                    addOns.add({"name": addOnName, "price": addOnPrice});
                  });
                }
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  )),
              child: Text(
                "Add Add Ons",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cakeQuantity(context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
            child: Text(
              "Cake Quantity",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (quantity > 1) {
                        --quantity;
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(14)),
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(14)),
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "$quantity",
                    style: TextStyle(color: Colors.grey[800], fontSize: 18),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      ++quantity;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(14)),
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _cakeDeliveryDate(context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
            child: Text(
              "Cake Delivery Time",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: EdgeInsets.all(18),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      dateTime == null
                          ? "Select Date"
                          : DateFormat.yMMMMd('en_US').format(dateTime),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2028))
                          .then((date) {
                        setState(() {
                          dateTime = date;
                        });
                      });
                    },
                    child: Container(
                      child:
                          Icon(Icons.calendar_today, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(18, 0, 18, 18),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      time == null
                          ? "Select Time"
                          : time.hour.toString() +
                              ":" +
                              time.minute.toString() +
                              " Hours",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: 12, minute: 00),
                      ).then((date) {
                        setState(() {
                          time = date;
                        });
                      });
                    },
                    child: Container(
                      child:
                          Icon(Icons.calendar_today, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _imageDisplayer(context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
            child: Text(
              "Cake Image",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            child: Container(
              child: (file == null)
                  ? Container(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: Text("Nothing to display !"),
                      ),
                    )
                  : Center(
                      child: Image.file(file),
                    ),
            ),
          ),
          InkWell(
            onTap: () {
              pickImage();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  )),
              child: Text(
                "Pick an Image",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextArea(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
          child: TextField(
            controller: messageController,
            onChanged: (value) {
              setState(() {
                message = value;
              });
            },
            maxLines: 7,
            decoration:
                InputDecoration.collapsed(hintText: "Enter your Message here"),
          ),
        ),
      ),
    );
  }

  Widget _checkoutButton(context) {
    return InkWell(
      onTap: () {
        print(message);
        Get.toNamed("/customCheckout", arguments: {
          "name": name,
          "unit": unit,
          "weight": weight,
          "date": DateFormat.yMMMMd('en_US').format(dateTime),
          "time":
              time.hour.toString() + ":" + time.minute.toString() + " Hours",
          "quantity": quantity,
          "imageUrl": file,
          "pricePerQty": pricePerQty,
          "addOns": addOns,
          "message": message
        });
        messageController.clear();
        _nameController.clear();
        _weightController.clear();
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            "Proceed to Checkout",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
