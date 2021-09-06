import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageGridWidget extends StatefulWidget {
  final int index;
  final String image;
  final String folder;

  ImageGridWidget({this.index, this.folder, this.image});

  @override
  _ImageGridWidgetState createState() => _ImageGridWidgetState();
}

class _ImageGridWidgetState extends State<ImageGridWidget> {
  Uint8List imageFile;
  StorageReference imageReference;

  getImage() {
    imageReference
        .child("${widget.image}")
        .getData(2 * 1024 * 1024)
        .then((data) {
      this.setState(() {
        imageFile = data;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void initState() {
    super.initState();

    imageReference =
        FirebaseStorage.instance.ref().child("gallery/${widget.folder}");
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: GridTile(
        child: imageFile == null
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Image.memory(
                imageFile,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
