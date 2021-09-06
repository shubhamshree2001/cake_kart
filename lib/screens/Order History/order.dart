import 'package:flutter/material.dart';
import 'package:notification/screens/Order%20History/walkInOrderHistory.dart';
import 'package:notification/screens/Order%20History/orderHistory.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildTabBar(context),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            tabs: [
              Tab(text: "Regular",),
              Tab(text: "Walk-In",)
            ],
            labelColor: Colors.grey[900],
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[900],
                  width: 3
                ),
              )
            ),
          ),
          body:TabBarView(
            children: [
              OrderHistoryScreen(),
              WalkInOrderHistory(),
            ],
          ),
        ),
      ),
    );
  }

}