import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:notification/providers/cart.dart';
import 'package:notification/widgets/cart.dart';
import 'package:provider/provider.dart';
import 'package:notification/providers/address.dart';

class DryCartPage extends StatelessWidget {
  List _cartList;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[900],
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        "My Cart",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.grey[900],
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            Get.back();
          }),
      toolbarHeight: 70,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[900],
      ),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: _buildColumn(context),
      ),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      children: [
        _buildListItem(context),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildListItem(BuildContext context) {
    final _cartListProvider = Provider.of<CartProvider>(context);
    _cartList = _cartListProvider.cartList;
    return Container(
      child: Expanded(
          child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[300]),
              child: _cartList.length != 0
                  ? ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (_, index) {
                        return CartItem(
                          cartDetails: _cartList[index],
                        );
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 140,
                          decoration: BoxDecoration(),
                          child: SvgPicture.asset("assets/svg/cart.svg"),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text("No items in cart!"),
                        )
                      ],
                    ))),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 20),
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          )),
      child: Column(
        children: [
          _buildInfo(context),
          _buildButton(context),
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    final _cartListProvider = Provider.of<CartProvider>(context);
    final _addressProvider = Provider.of<AddressProvider>(context);
    final _totalAmount = _cartListProvider.getTotalAmount();
    final _margin = _addressProvider.margin * 0.01;
    final _discount = _totalAmount * _margin;
    final _finalAmount = _totalAmount - _discount;
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                "Total Sum            ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                '$_totalAmount',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Discounted Sum    ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                '$_finalAmount',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    final _cartListProvider = Provider.of<CartProvider>(context);
    final _addressProvider = Provider.of<AddressProvider>(context);
    final _totalAmount = _cartListProvider.getTotalAmount();
    final _margin = _addressProvider.margin * 0.01;
    final _discount = _totalAmount * _margin;
    final _finalAmount = _totalAmount - _discount;
    return Material(
      color: Colors.yellow[900],
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          Future.delayed(Duration(milliseconds: 200), () {
            Get.toNamed(
              '/checkout',
              arguments: _finalAmount,
            );
          });
        },
        child: Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              //color: Colors.yellow[900],
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "CHECKOUT",
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(
                    Icons.payment,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
