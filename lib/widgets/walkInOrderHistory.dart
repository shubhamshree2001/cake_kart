import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalkInOrderHistoryWidget extends StatelessWidget {

  final String name;
  final String price;
  final String orderNumber;
  final String time;

  WalkInOrderHistoryWidget({this.name = "",this.price = "",this.orderNumber = "",this.time = ""});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/walkInOrderDetails',arguments: int.parse(orderNumber));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text("Order Number - $orderNumber")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amount  $price"),
                Text("$time")
              ],
            ),
          ],
        ),
      ),
    );
  }
}