import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,  
      width: double.infinity,
      child: Column(
        children: [
          _buildChalaan(context),
          _buildBill(context),
          _buildDisplay(context),
          _buildText(context),
        ],
      ),
    );
  }

  Widget _buildChalaan(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed("/chalaan");
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(16,20,16,16),
        padding: EdgeInsets.all(16),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    "CHALAAN",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 80,
              child: SvgPicture.asset(
                "assets/svg/chalaan.svg",
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBill(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed("/receipt");
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(16,0,16,16),
        padding: EdgeInsets.all(16),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    "RECEIPTS",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 80,
              child: SvgPicture.asset(
                "assets/svg/bill.svg",
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplay(context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.fromLTRB(16,0 ,16,0),
        child: Image.asset("assets/images/display.png",fit: BoxFit.fitWidth,),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Text(
        "Check your Chalaan and Receipts!",
        style: TextStyle(
          fontSize: 16
        ),
      ),      
    );
  }

}