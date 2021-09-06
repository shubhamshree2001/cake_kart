import 'package:flutter/material.dart';
import 'package:notification/screens/gallery/Sub%20Gallery/cake.dart';
import 'package:notification/screens/gallery/Sub%20Gallery/cake4.dart';
import 'package:notification/screens/gallery/Sub%20Gallery/sub2.dart';
import 'package:notification/screens/gallery/Sub%20Gallery/sub3.dart';
import 'package:provider/provider.dart';
import 'package:notification/providers/categories.dart';
import 'package:notification/providers/imagesCategories.dart';
import 'package:notification/widgets/imageGrid.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<Map<String, dynamic>> categoryList = [];
  bool isLoading = false;
  List categories = [];
  int i = 0;
  @override
  Widget build(BuildContext context) {
    categories.clear();
    i = 0;
    return Container(
      child: _buildTabBar(context),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final categoriesProvider = Provider.of<ImagesCategoriesProvider>(context);
    final categoriesLength = categoriesProvider.categoryLength();
    final categoryNames = categoriesProvider.categoryName();
    final categoryIDNames = categoriesProvider.categoryID();
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: DefaultTabController(
        length: categoriesLength,
        child: Scaffold(
          appBar: TabBar(
            isScrollable: categoriesLength <= 4 ? false : true,
            tabs: categoryNames.map((i) {
              categories.add(i);
              return Tab(
                text: "$i",
              );
            }).toList(),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.teal,
            indicator: BoxDecoration(
                color: Colors.teal[50],
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
                  children: categoryIDNames.map((e) {
                    String folder = categories[i];
                    i++;
                    print(folder);
                    return GridView.builder(
                        itemCount: e.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (_, index) {
                          print(e[index]);
                          return ImageGridWidget(
                            index: index,
                            folder: folder,
                            image: e[index],
                          );
                        });
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
