import 'package:flutter/material.dart';
import 'package:notification/screens/Order%20History/walkInOrder.dart';
import 'package:notification/screens/Order%20History/regularOrders.dart';
import 'package:notification/screens/Order%20History/dryOrderHistory.dart';

class ScreenTwo extends StatefulWidget {
  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            tabs: [
              Tab(
                text: "Regular",
              ),
              Tab(
                text: "Walk-In",
              ),
              Tab(
                text: "Dry",
              )
            ],
            labelColor: Colors.grey[900],
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[900], width: 3),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              OrderHistoryScreen(),
              WalkInOrderHistory(),
              DryOrderHistory(),
            ],
          ),
        ),
      ),
    );
  }
}
