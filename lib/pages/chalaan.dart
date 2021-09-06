import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChalaanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppbar(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      toolbarHeight: 64,
      backgroundColor: Colors.grey[100],
      title: Text(
        "CHALAAN",
        style: GoogleFonts.roboto(
          fontSize: 16,
          color: Colors.grey[800],
          fontWeight: FontWeight.w600
        ),
      ),
      leadingWidth: 66,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios,size: 20,),
        onPressed: () {
          Get.back();
        },
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(18),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("chalaan").where("uid",isEqualTo: "KW8BmJeAkZTCumiGPvYifuqCUzG2").snapshots(),
        builder: (context,snapshot) {
          List data = snapshot.data.documents;
          data = data.reversed.toList();
          // return Text(data[0]["message"].toString());
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: data.map((data){
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical:8 ),
                    margin: EdgeInsets.symmetric(horizontal: 8,vertical:2 ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text(data["message"]),
                  )
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

}