import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageLoaderWidget extends StatefulWidget {
  final imageUrl;
  ImageLoaderWidget({this.imageUrl});

  @override
  _ImageLoaderWidgetState createState() => _ImageLoaderWidgetState();
}

class _ImageLoaderWidgetState extends State<ImageLoaderWidget> {
  bool isLoading = true;
  Uint8List imageFile;

  void loadData() {
    StorageReference imageReference =
        FirebaseStorage.instance.ref().child(widget.imageUrl);
    imageReference.getData(3 * 1024 * 1024).then((data) async {
      // Directory appDocumentsDirectory =
      // await getApplicationDocumentsDirectory(); // 1

      this.setState(() {
        // await getFilePath(widget.imageUrl);
        imageFile = data;
        isLoading = false;
      });
    }).catchError((error) {
      print(error);
    });
  }

  void initState() {
    super.initState();
    loadData();
  }

  // Future<String> getFilePath(String name) async {
  //   Directory appDocumentsDirectory =
  //       await getApplicationDocumentsDirectory(); // 1

  //   String appDocumentsPath = appDocumentsDirectory.path; // 2
  //   String filePath = '$appDocumentsPath/$name}'; // 3

  //   return filePath;
  // }

  // void saveFile() async {
  //   File file = File(await getFilePath('name')); // 1
  //   file.writeAsString(
  //       "This is my demo text that will be saved to : demoTextFile.txt"); // 2
  // }

  // void readFile() async {
  //   File file = File(await getFilePath()); // 1
  //   String fileContent = await file.readAsString(); // 2

  //   print('File Content: $fileContent');
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 200,
      ),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromRGBO(220, 220, 220, 1),
          borderRadius: BorderRadius.circular(13)),
      child: isLoading
          ? Center(
              child: Container(width: 30, child: LinearProgressIndicator()),
            )
          : ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
              child: Image.memory(
                imageFile,
                fit: BoxFit.contain,
              ),
            ),
    );
  }
}
