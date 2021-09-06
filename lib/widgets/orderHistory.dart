import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'popup.dart';

class OrderHistoryWidget extends StatelessWidget {
  final String name;
  final String price;
  final String orderNumber;
  final String time;
  final String ordertime;
  final String deliverydate;
  final List items;
  final String status;
  final String uid;

  OrderHistoryWidget(
      {this.name = "",
      this.items,
      this.deliverydate = '',
      this.ordertime = '',
      this.status = '',
      this.uid = '',
      this.price = "",
      this.orderNumber = "",
      this.time = ""});

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
                ordertime: ordertime,
                deliverydate: deliverydate,
                orderNumber: orderNumber,
                time: time,
                items: items,
                status: status,
                uid: uid);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(items.length.toString() + ' items'),
                Text(orderNumber),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Amount  $price"), Text("Status" + ": $status")],
            ),
            Text("Order Date -  $time"),
            Text("Order Time -  $ordertime"),
            Text("Delivery Date -  $deliverydate"),
          ],
        ),
      ),
    );
  }
}
