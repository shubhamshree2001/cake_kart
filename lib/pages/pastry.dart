import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notification/Subcategories/pastry.dart';
import 'package:notification/providers/cart.dart';
import 'package:notification/providers/walkInCategories.dart';
import 'package:provider/provider.dart';

class PastryPage extends StatefulWidget {
  @override
  _PastryPageState createState() => _PastryPageState();
}

class _PastryPageState extends State<PastryPage> {
  List<Map<String, dynamic>> categoryList = [];
  bool isLoading = false;
  List categories = [];

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.pink[100],
          statusBarBrightness: Brightness.light),
      child: SafeArea(
        child: Scaffold(
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.pink[200],
      ),
      child: Column(
        children: [
          _buildNavBar(context),
          _buildMenu(context),
        ],
      ),
    );
  }

  Widget _buildNavBar(BuildContext context) {
    final _cartListProvider = Provider.of<CartProvider>(context);
    int getCount() {
      int n = 0;
      _cartListProvider.cartList.forEach((element) {
        n += element.quantity;
      });
      return n;
    }

    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: double.infinity,
      color: Colors.pink[200],
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: () {
                      Get.back();
                    }),
              ),
            ),
            // Expanded(
            //     child: Container(
            //   margin: EdgeInsets.symmetric(horizontal: 10),
            //   height: 40,
            //   decoration: BoxDecoration(
            //       color: Colors.white, borderRadius: BorderRadius.circular(10)),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Container(
            //         margin: EdgeInsets.symmetric(horizontal: 10),
            //         child: Icon(
            //           Icons.search,
            //           size: 24,
            //           color: Colors.pink,
            //         ),
            //       ),
            //       Container(
            //         child: Text(
            //           "Search your dishes",
            //           style: TextStyle(color: Colors.black.withOpacity(0.4)),
            //         ),
            //       )
            //     ],
            //   ),
            // )),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black.withOpacity(0.75),
                        size: 22,
                      ),
                      onPressed: () {
                        Get.toNamed('/cart');
                      },
                    ),
                    Positioned(
                      left: 1,
                      // top:,
                      child: Text(
                        getCount().toString(),
                      ),
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

  Widget _buildMenu(BuildContext context) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 0),
          margin: EdgeInsets.only(top: 10),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(13),
                topLeft: Radius.circular(13),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.25),
                  blurRadius: 4,
                  spreadRadius: 4,
                  offset: Offset(0, -2),
                ),
              ]),
          child: _buildTabBar(context)),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    // TabController _tabController = new TabController(length: 5,vsync: Widget.this);
    final categoriesProvider = Provider.of<WalkInCategoriesProvider>(context);
    final categoriesLength = categoriesProvider.categoryLength();
    final categoryNames = categoriesProvider.categoryName();
    final categoryIDNames = categoriesProvider.categoryID();
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: DefaultTabController(
        length: categoriesLength,
        child: Scaffold(
          appBar: TabBar(
            isScrollable: categoriesLength <= 4 ? false : true,
            tabs: categoryNames
                .map((i) => Tab(
                      text: "$i",
                    ))
                .toList(),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.pink,
            indicator: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(
                  children: categoryIDNames
                      .map((e) => new PastrySubCategory(e.toString()))
                      .toList(),
                ),
        ),
      ),
    );
  }
}
