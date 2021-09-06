import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatefulWidget {

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  final orderNumber = Get.arguments;
  var amount = "";
  List list = [];
  List qty = [];
  var i = -1;
  bool isLoading = true;
  var time = "";

  void loadData() {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("orders");
    collectionReference.where("Order Number",isEqualTo: orderNumber).snapshots().listen((value){
      list = value.docs[0]["orders"];
      qty = value.docs[0]["order_quantity"];
      amount = value.docs[0]["amount"].toString();
      time = value.docs[0]["time"].toString().substring(0,10);
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
                    "Date of Order",
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
                    "\nItem Names",
                    style: TextStyle( 
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(
                    "\nQuantity",
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                ],
              ), 
              Column(
                children: list.map((e){
                  ++i;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.toString()),
                      Text(qty[i].toString()),
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