import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notification/widgets/oldOrderHistoryWidget.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List orderhistory = [];

  bool isLoading = true;

  void loadData() {
    setState(() {
      orderhistory.clear();
    });
    final userUid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("orders");
    collectionReference
        .where("UID", isEqualTo: userUid)
        .snapshots()
        .listen((value) {
      for (int i = 0; i < value.docs.length; ++i) {
        // print(value.docs[i]["Order Number"]);

        setState(() {
          orderhistory.add(value.docs[i]);
          // print(orderhistory);
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    orderhistory.clear();
    loadData();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: InkWell(
          onTap: () {
            loadData();
          },
          child: Container(
            height: double.infinity,
            color: Colors.grey[100],
            padding: EdgeInsets.only(bottom: 16),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: orderhistory
                          .map((e) => OldOrderHistoryWidget(
                                orderNumber: e["Order Number"].toString(),
                                price: e["amount"],
                                time: e["time"].toString().substring(0, 10),
                                // name: e["name"],
                                // items: e["orders"],
                              ))
                          .toList(),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
