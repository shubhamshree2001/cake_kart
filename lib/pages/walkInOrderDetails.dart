import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WalkInOrderDetailsPage extends StatefulWidget {
  @override
  _WalkInOrderDetailsPageState createState() => _WalkInOrderDetailsPageState();
}

class _WalkInOrderDetailsPageState extends State<WalkInOrderDetailsPage> {

  final orderNumber = Get.arguments;
  var amount = "";
  List list = [];
  var qty = "";
  var i = -1;
  bool isLoading = true;
  var timeOfOrder = "";
  var time = "";
  var date = "";
  var name = "";
  var weight = "";
  var units = "";
  var pricePerQtyName = "";
  var pricePerQty = "";
  List addOns = [];

  void loadData() {
    print("OrderNumber - $orderNumber");
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("/walkInOrders");
    collectionReference.where("Order Number",isEqualTo: orderNumber).snapshots().listen((value){
      addOns = value.docs[0]["addOns"];
      // qty = value.docs[0]["order_quantity"];
      amount = value.docs[0]["amount"].toString();
      timeOfOrder = value.docs[0]["time"].toString().toString().substring(0,10);
      time = value.docs[0]["order"]["Delivery time"].toString().substring(0,10);
      date = value.docs[0]["order"]["Delivery date"].toString();
      qty = value.docs[0]["order"]["quantity"].toString();
      name = value.docs[0]["order"]["Cake Name"].toString();
      weight = value.docs[0]["order"]["weight"].toString();
      units = value.docs[0]["order"]["unit"].toString();
      pricePerQtyName = value.docs[0]["PricePerQuantiy"]["name"];
      pricePerQty = value.docs[0]["PricePerQuantiy"]["price"];
      setState(() {
        isLoading = false;
      });
    });
    
  }

  @override

  void initState() {
    super.initState();
    loadData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        "Order Details",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      centerTitle: true,
      leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 20,color: Colors.white),onPressed: (){Get.back();},),
      backgroundColor: Colors.grey[900],
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.grey[900],
      child: Column(
        children: [
          _buildCakeIcon(),
          _buildDetails(),
        ],
      ),
    );
  }

  Widget _buildCakeIcon(){
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
      ),
      child: SvgPicture.asset("assets/svg/cake.svg"),
    );
  }

  Widget _buildDetails() {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
        ),
        child: isLoading
        ? Container(child: Center(child: CircularProgressIndicator(),),)
        : SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Number",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(orderNumber.toString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Date",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(timeOfOrder),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date of Delivery",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(date),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Time of Delivery",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(time),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cake Name",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(name),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cake Weight",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(weight),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Weight Unit",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(units),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cake Quantity",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(qty),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\nPrice per Quantity",
                    style: TextStyle( 
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(
                    "\nPrice",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pricePerQtyName,
                    style: TextStyle(
                    ),
                  ),
                  Text(pricePerQty),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\nAdd-Ons",
                    style: TextStyle( 
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(
                    "\nPrice",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                ],
              ),
              Column(
                children: addOns.map((e){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e["name"].toString()),
                      Text(e["price"].toString()),
                    ],
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\nAmount to Pay",
                    style: TextStyle( 
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(
                    "\n$amount",
                    style: TextStyle(
                      color: Colors.indigoAccent
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}