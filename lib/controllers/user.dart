import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  RxMap user = {"name" : "loading","contact" : "loading"}.obs;



  void updateUser({name,contact,mail,address}) {
    user.value["name"] = name;
    user.value["contact"] = contact;
    user.value["mail"] = mail;
    user.value["address"] = address;
    update();
    print(user);
  }

  void init() {
    final user =  FirebaseAuth.instance.currentUser;
    String uid = user.uid;
    // ignore: deprecated_member_use
    DocumentReference documentReference = FirebaseFirestore.instance.collection('users').document(uid);
    documentReference.get()
    .then(
      (userSnap) {
        //print(userSnap.data());
        final user = userSnap.data();
        final UserController userController = Get.find();
        userController.updateUser(
          name: user["name"],
          contact: user["contact"],
          mail: user["mail"],
          address: user["address"],
        );
      }
    );
  }

  void showUser(){
    printError(info:user.toString());
  }

  void onInit() {
    showUser();
  }

}