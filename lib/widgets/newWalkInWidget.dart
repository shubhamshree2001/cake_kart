import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'walkInPopup.dart';

class NewWalkInHistory extends StatelessWidget {
  final String name;
  final String price;
  final String orderNumber;
  final String time;
  final String status;
  final items;

  NewWalkInHistory(
      {this.name = "",
      this.items,
      this.price = "",
      this.orderNumber = "",
      this.time = "",
      this.status = ''});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed('/orderDetails', arguments: int.parse(orderNumber));
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              name: name,
              price: price,
              orderNumber: orderNumber,
              time: time,
              items: items,
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [Text(items['quantity'].toString() + ' items')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Amount  $price"), Text("Status - $status")],
            ),
          ],
        ),
      ),
    );
  }
}
