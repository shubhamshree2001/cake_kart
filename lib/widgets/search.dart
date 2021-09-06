import 'package:flutter/material.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:notification/widgets/post.dart';

class CustomSearchDelegate extends SearchDelegate<PostWidget> {
  final List categories;
  CustomSearchDelegate({this.categories});
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ' ';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final results = categories
        .where((e) => e["name"].toLowerCase().contains(query))
        .toList();
    // TODO: implement buildSuggestions
    return GridView.builder(
      itemCount: results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.7,
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
      itemBuilder: (BuildContext context, int index) {
        return new Card(
          child: new GridTile(
            // footer: new Text(data[index]['name']),
            child: new PostWidget(
              imageUrl: results[index]["productImage"],
              cakeName: results[index]["name"],
              price: results[index]["price"].toString(),
              weight: results[index]["weight"],
              unit: results[index]["unit"],
              status: results[index]["status"],
            ), //just for testing, will fill with image later
          ),
        );
      },
    );
  }
}
