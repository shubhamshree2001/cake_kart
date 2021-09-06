import 'package:flutter/material.dart';
import 'package:notification/providers/cart.dart';
import 'package:notification/widgets/imageLoader.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatelessWidget {
  final String imageUrl;
  final String cakeName;
  final String price;
  final String weight;
  final String unit;
  final int status;

  PostWidget(
      {this.imageUrl,
      this.status,
      this.cakeName,
      this.price,
      this.weight,
      this.unit});

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300],
                blurRadius: 4,
                spreadRadius: 2,
                offset: Offset(0, 4))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: screenheight * 0.15,
            width: screenwidth * 0.47,
            child: ImageLoaderWidget(
              imageUrl: imageUrl != null ? imageUrl : "Regular/abc/finalfinal",
            ),
          ),
          _buildLowerBody(context),
        ],
      ),
    );
  }

  Widget _buildLowerBody(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    final _cartListProvider = Provider.of<CartProvider>(context);
    var _itemQuantity = _cartListProvider.getQuantity(cakeName);
    bool _showQauntity = _cartListProvider.showQuantityController(cakeName);
    return Container(
      padding: EdgeInsets.all(13),
      height: screenheight * 0.18,
      // width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                  text: cakeName,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(
                      text: '''\n\nRs ''',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: "$price",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                        text: "\t\t\t$weight $unit",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        )),
                  ]),
            ),
          ),
          Expanded(
            child: Container(
                width: screenwidth,
                // padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _showQauntity
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.remove_circle,
                                size: 18,
                                color: Colors.grey[600],
                              ),
                              onPressed: () {
                                _cartListProvider.decreaseCount(cakeName);
                              }),
                          Text("$_itemQuantity"),
                          IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                size: 18,
                                color: Colors.blueAccent[700],
                              ),
                              onPressed: () {
                                _cartListProvider.increaseCount(cakeName);
                              }),
                        ],
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.add_shopping_cart,
                          size: 20,
                        ),
                        onPressed: () {
                          _cartListProvider.addToCartList(
                              name: cakeName,
                              price: double.parse(price),
                              weight: weight,
                              unit: unit,
                              quantity: 1);
                        },
                      )),
          )
        ],
      ),
    );
  }
}
