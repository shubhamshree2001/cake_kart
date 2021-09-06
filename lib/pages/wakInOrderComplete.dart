import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WalkInOrderComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.grey[900],
      ),
    );
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                      ),
                      child: SvgPicture.asset("assets/svg/cake.svg",fit: BoxFit.fitWidth,),
                    ),
                    Container(
                       padding: EdgeInsets.all(12),
                      child: Text(
                        "YOUR ORDER HAS BEEN PLACED SUCCESSFULLY!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Get.until((route) => Get.currentRoute == "/premium" );
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(18),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent[700],
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Center(
                  child: Text(
                    "Return to Custom Order",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}