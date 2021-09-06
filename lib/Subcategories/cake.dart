import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification/widgets/post.dart';
import 'package:notification/widgets/search.dart';

class CakeSubCategory extends StatefulWidget {
  final String cakeName;
  CakeSubCategory(this.cakeName);

  @override
  _CakeSubCategoryState createState() => _CakeSubCategoryState();
}

class _CakeSubCategoryState extends State<CakeSubCategory> {
  List categories = [];
  bool isLoading = true;

  void loadData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(
            "/category/bZ82LjA8Ca2iNScm7wQb/Regular/${widget.cakeName}/Products")
        .get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var categoryItem = querySnapshot.docs[i];
      if (categoryItem.data()['status'] == 1) {
        categories.add(categoryItem.data());
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    print(categories);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.teal,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(categories: categories),
                    );
                  },
                  child: Container(
                    child: Text(
                      "Search your Cake",
                      style: TextStyle(color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          // height: double.infinity
          // width: double.infinity,
          padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
          color: Colors.white,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.7,
                      crossAxisCount:
                          (orientation == Orientation.portrait) ? 2 : 3),
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      child: new GridTile(
                        // footer: new Text(data[index]['name']),
                        child: new PostWidget(
                          imageUrl: categories[index]["productImage"],
                          cakeName: categories[index]["name"],
                          price: categories[index]["price"].toString(),
                          weight: categories[index]["weight"],
                          unit: categories[index]["unit"],
                          status: categories[index]["status"],
                        ), //just for testing, will fill with image later
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}






// ListView.builder(
//               itemCount: categories.length,
//               itemBuilder: (_, index) {
//                 return PostWidget(
//                   imageUrl: categories[index]["productImage"],
//                   cakeName: categories[index]["name"],
//                   price: categories[index]["price"].toString(),
//                   weight: categories[index]["weight"],
//                   unit: categories[index]["unit"],
//                   status: categories[index]["status"],
//                 );
//               },
//             ),