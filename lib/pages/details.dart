import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification/providers/address.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  static final nameController = TextEditingController();
  static final contactController = TextEditingController();
  static final mailController = TextEditingController();
  static final addressController1 = TextEditingController();
  static final addressController2 = TextEditingController();
  static final addressController3 = TextEditingController();

  final Map<String,String> userdata = new Map();

  void addToMap() {
    userdata["name"] = nameController.text;
    userdata["contact"] = contactController.text;
    userdata["mail"] = mailController.text;
    userdata["address1"] = addressController1.text;
    userdata["address2"] = addressController2.text;
    userdata["address3"] = addressController3.text;
  }

  void onSubmit() {
    addToMap();
    final _addressProvider = Provider.of<AddressProvider>(context,listen: false);
    _addressProvider.name = userdata["name"];
    _addressProvider.contact = userdata["contact"];
    _addressProvider.email = userdata["mail"];
    _addressProvider.addressLine1 = userdata["address1"];
    _addressProvider.addressLine2 = userdata["address2"];
    _addressProvider.addressLine3 = userdata["address3"];
    print(userdata);
    final user = FirebaseAuth.instance.currentUser;
    String uid = user.uid;
    // ignore: deprecated_member_use
    DocumentReference documentReference = FirebaseFirestore.instance.collection('users').document(uid);
    documentReference.set(userdata);
    Get.snackbar(
      "User Detail",
      "Updated Successfully!",
      titleText: Text("User Detail",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
      messageText: Text("Updated Successfully!",style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 12,),),
      isDismissible: true,
      backgroundColor: Colors.grey[900],
      colorText: Colors.black87,
      margin: EdgeInsets.fromLTRB(5,15,5,5),
      barBlur: 2,
      overlayBlur: 0,
    );
    Future.delayed(Duration(seconds: 2),(){
      Get.offAndToNamed('/homePage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        centerTitle: true,
        title:Text(
          "User Detail",
          style: GoogleFonts.ubuntu(
            fontSize: 18,
            color: Color.fromRGBO(50, 50, 50, 1)
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildForm(),
        _buildSubmitButton()
      ],
    );
  }

  Widget _buildForm() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(margin: EdgeInsets.only(right: 14),child: Icon(Icons.supervised_user_circle,color: Colors.grey[800],size: 28,)),
                    Expanded(
                      child: TextFormField(
                        controller: nameController,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor: Colors.grey[800],
                        cursorRadius: Radius.circular(18),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                            fontSize: 18,
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                            )
                          ) 
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Container(margin: EdgeInsets.only(right: 14),child: Icon(Icons.phone,color: Colors.grey[800],size: 28,)),
                    Expanded(
                      child: TextFormField(
                        controller: contactController,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor: Colors.grey[800],
                        cursorRadius: Radius.circular(18),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Contact Number",
                          hintStyle: TextStyle(
                            fontSize: 18,
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                            )
                          ) 
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Container(margin: EdgeInsets.only(right: 14),child: Icon(Icons.mail,color: Colors.grey[800],size: 28,)),
                    Expanded(
                      child: TextFormField(
                        controller: mailController,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor: Colors.grey[800],
                        cursorRadius: Radius.circular(18),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontSize: 18,
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                            )
                          )
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(margin: EdgeInsets.only(right: 14,top: 14),child: Icon(Icons.location_on,color: Colors.grey[800],size: 28,)),
                    Expanded(
                      child: TextFormField(
                        controller: addressController1,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor: Colors.grey[800],
                        cursorRadius: Radius.circular(18),
                        keyboardType: TextInputType.streetAddress,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Address Line 1",
                          hintStyle: TextStyle(
                            fontSize: 18,
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                            )
                          ) 
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(margin: EdgeInsets.only(right: 14,top: 14),child: Icon(Icons.location_on,color: Colors.grey[800],size: 28,)),
                    Expanded(
                      child: TextFormField(
                        controller: addressController2,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor: Colors.grey[800],
                        cursorRadius: Radius.circular(18),
                        keyboardType: TextInputType.streetAddress,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Address Line 2",
                          hintStyle: TextStyle(
                            fontSize: 18,
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                            )
                          ) 
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(margin: EdgeInsets.only(right: 14,top: 14),child: Icon(Icons.location_on,color: Colors.grey[800],size: 28,)),
                    Expanded(
                      child: TextFormField(
                        controller: addressController3,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor: Colors.grey[800],
                        cursorRadius: Radius.circular(18),
                        keyboardType: TextInputType.streetAddress,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Address Line 3",
                          hintStyle: TextStyle(
                            fontSize: 18,
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                            )
                          ) 
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ) 
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Material(
        color: Colors.grey[900],
        shadowColor: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: (){
            onSubmit();
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Text("Submit", style: TextStyle(fontSize: 18,color: Colors.white),),
            ),
          ),
        ),
      ),
    );
  }
}