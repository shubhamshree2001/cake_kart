import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification/providers/address.dart';
import 'package:provider/provider.dart';

class AddressDetailsCustomPage extends StatefulWidget {

  @override
  _AddressDetailsCustomPageState createState() => _AddressDetailsCustomPageState();
}

class _AddressDetailsCustomPageState extends State<AddressDetailsCustomPage> {

  static final address1 = TextEditingController();
  static final address2 = TextEditingController();
  static final address3 = TextEditingController();

  void onSubmit() {
    Get.snackbar(
      "Address Details",
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
      Get.until((route) => Get.currentRoute == "/customCheckout" );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        centerTitle: true,
        title:Text(
          "Address Details",
          style: GoogleFonts.ubuntu(
            fontSize: 18,
            color: Colors.grey[700]
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildIcon(),
        _buildForm(),
        _buildMap(),
        _buildSubmitButton(context)
      ],
    );
  }

  Widget _buildIcon() {
    return  Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12)
      ),
      child: Icon(
        Icons.location_on,
        color: Colors.redAccent[700],
      ),
    );
  }

  Widget _buildForm() {
    final _addressProvider = Provider.of<AddressProvider>(context);
    return Container(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    _addressProvider.addressLine1 = address1.text;
                  },
                  textAlign: TextAlign.center,
                  controller: address1,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  cursorColor: Colors.grey[800],
                  cursorRadius: Radius.circular(18),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "${_addressProvider.addressLine1}",
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                    focusedBorder:UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow[900],
                        width: 2,
                      )
                    ) 
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    _addressProvider.addressLine2 = address2.text;
                  },
                  textAlign: TextAlign.center,
                  controller: address2,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  cursorColor: Colors.grey[800],
                  cursorRadius: Radius.circular(18),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "${_addressProvider.addressLine2}",
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                    focusedBorder:UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow[900],
                        width: 2,
                      )
                    ) 
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    _addressProvider.addressLine3 = address3.text;
                  },
                  textAlign: TextAlign.center,
                  controller: address3,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  cursorColor: Colors.grey[800],
                  cursorRadius: Radius.circular(18),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "${_addressProvider.addressLine3}",
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                    focusedBorder:UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow[900],
                        width: 2,
                      )
                    ) 
                  ),
                ),
              ],
            ),
          ),
        ),
      ) 
    );
  }

  Widget _buildMap() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage("assets/images/map.png"),
                    fit: BoxFit.fitWidth,
                  )
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed('/mapPreload');
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(8,0,8,8),
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Set Map Location",
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Material(
        color: Colors.yellow[900],
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