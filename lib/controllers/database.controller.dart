import 'package:boba_time/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  static DatabaseController get to => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<List<UserModel>> searchForUsers({@required String userName}) {
//    return _db
//         .collection('/users')
//        .where("name", : userName)
//        .getDocuments()
//        .then((value) => UserModel.fromMap(value));
  }
}
