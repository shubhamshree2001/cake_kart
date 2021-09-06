import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slimy_card/slimy_card.dart';
import 'popup.dart';

class OldOrderHistoryWidget extends StatelessWidget {
  final String price;
  final String orderNumber;
  final String time;

  OldOrderHistoryWidget(
      {this.price = "", this.orderNumber = "", this.time = ""});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   // Get.toNamed('/orderDetails', arguments: int.parse(orderNumber));
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return CustomDialogBox(
      //         price: price,
      //         orderNumber: orderNumber,
      //         time: time,
      //       );
      //     },
      //   );
      // },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [Text("Order Number - $orderNumber")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Amount  $price"), Text("$time")],
            ),
          ],
        ),
      ),
    );
  }
}
