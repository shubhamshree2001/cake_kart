import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification/widgets/post.dart';

class DrySubCategory extends StatefulWidget {
  final String cakeName;
  DrySubCategory(this.cakeName);

  @override
  _DrySubCategoryState createState() => _DrySubCategoryState();
}

class _DrySubCategoryState extends State<DrySubCategory> {
  List categories = [];
  bool isLoading = true;

  void loadData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(
            "/category/bZ82LjA8Ca2iNScm7wQb/Dry/${widget.cakeName}/Products")
        .get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var categoryItem = querySnapshot.docs[i];
      categories.add(categoryItem.data());
      print("items are");
      // print(categoryItem.data());
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
    print(categories);

    return Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
        color: Colors.white,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                //  categories[index]["productImage"]
                itemCount: categories.length,
                itemBuilder: (_, index) {
                  return PostWidget(
                    imageUrl: categories[index]['productImage'],
                    cakeName: categories[index]["name"],
                    price: categories[index]["price"].toString(),
                    weight: categories[index]['weight'].toString(),
                    unit: categories[index]['unit'].toString(),
                  );
                }));
  }
}
