import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildRegular(context),
          _buildPremium(context),
          _buildPastry(context),
          _buildDry(context),
          _buildSlider(context),
          _buildSliderOffer(context)
        ],
      ),
    );
  }

  Widget _buildLocationDisplay(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Container(
      width: screenwidth * 0.95,
      height: screenheight * 0.2,
      margin: EdgeInsets.fromLTRB(12, 15, 12, 0),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              "PIMPRI-CHINCHWAD, PUNE",
              style: GoogleFonts.ubuntu(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRegular(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Get.toNamed('/regular');
      },
      child: Container(
        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.teal, borderRadius: BorderRadius.circular(14)),
        // height: 100,
        height: screenheight * 0.13,

        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: RichText(
                  text: TextSpan(
                      text: "REGULAR",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "\nDaily Offers with best prices",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              height: 120,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
              ),
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      size: 30,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    onPressed: () {
                      Get.toNamed('/regular');
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremium(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Get.toNamed('/premium');
      },
      child: Container(
        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(14),
        ),
        // height: 100,
        height: screenheight * 0.13,
        // width: screenwidth * 0.95,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: RichText(
                  text: TextSpan(
                      text: "CUSTOM / WALK - IN",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "\nCreate & customize your own cake",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              height: 120,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
              ),
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      size: 30,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    onPressed: () {
                      Get.toNamed('/premium');
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastry(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Get.toNamed('/pastry');
      },
      child: Container(
        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.pink, borderRadius: BorderRadius.circular(14)),
        // height: 100,
        height: screenheight * 0.13,
        // width: screenwidth * 0.95,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: RichText(
                  text: TextSpan(
                      text: "PASTRY",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "\nThe best pastry in town",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              height: 120,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
              ),
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      size: 30,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    onPressed: () {
                      Get.toNamed('/pastry');
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDry(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Get.toNamed('/dry');
      },
      child: Container(
        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.redAccent, borderRadius: BorderRadius.circular(14)),
        // height: 100,
        height: screenheight * 0.13,
        // width: screenwidth * 0.95,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: RichText(
                  text: TextSpan(
                      text: "DRY PRODUCTS",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "\nWide Collection Of Dry Products",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              height: 120,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
              ),
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      size: 30,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    onPressed: () {
                      Get.toNamed('/pastry');
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Container(
      height: screenheight * 0.28,
      // width: screenwidth * 0.95,
      margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(220, 220, 220, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage("assets/images/cake1.jpg"),
            AssetImage("assets/images/cake3.jpg"),
          ],
          autoplay: true,
          animationCurve: Curves.easeInToLinear,
          animationDuration: Duration(milliseconds: 2500),
          dotSize: 0,
          dotBgColor: Colors.transparent,
          dotColor: Colors.black.withOpacity(0.4),
          dotIncreasedColor: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildSliderOffer(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Container(
      height: screenheight * 0.28,
      // width: screenwidth * 0.95,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(220, 220, 220, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Carousel(
          boxFit: BoxFit.cover,
          images: [
            AssetImage("assets/images/cake2.jpg"),
            AssetImage("assets/images/cake4.jpg"),
            AssetImage("assets/images/cake5.jpg"),
          ],
          autoplay: true,
          animationCurve: Curves.easeInToLinear,
          animationDuration: Duration(milliseconds: 2500),
          dotSize: 0,
          dotBgColor: Colors.transparent,
          dotColor: Colors.black.withOpacity(0.4),
          dotIncreasedColor: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }
}
