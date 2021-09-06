import 'package:flutter/material.dart';
import 'package:notification/widgets/imageGrid.dart';

class Dessert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.all(5),
      child: _buildImageGridBuilder(context),
    );
  }

  Widget _buildImageGridBuilder(BuildContext context) {
    return GridView.builder(
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
        ),
        itemBuilder: (_, index) {
          return ImageGridWidget(index: index, image: "Dessert");
        });
  }
}
