import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String name;
  final String price;
  final String orderNumber;
  final String time;
  final items;

  const CustomDialogBox({
    Key key,
    this.name = "",
    this.items,
    this.price = '',
    this.orderNumber = "",
    this.time = "",
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: 20.0, top: 45.0 + 20.0, right: 20.0, bottom: 20.0),
          margin: EdgeInsets.only(top: 45.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'DETAILS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Order Number - ' + widget.orderNumber,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                'Order Amount - ' + widget.price,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                'Order Time  ' + widget.time,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'ITEMS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                "Cake Name - " + widget.items['Cake Name'],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                "Delivery Date - " + widget.items['Delivery date'],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                "Delivery Time - " + widget.items['Delivery time'],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                "Quantity - " + widget.items['quantity'].toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                "Weight - " +
                    widget.items['weight'] +
                    " " +
                    widget.items['unit'],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20.0,
          right: 20.0,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45.0,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45.0)),
                child: Image.asset("assets/model.jpeg")),
          ),
        ),
      ],
    );
  }
}
