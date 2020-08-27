import 'package:boba_time/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'New Post',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: "PollyRounded"),
        ),
        elevation: 0,
      ),
      body: Container(
        color: AppThemes.bobaGreen,
        width: Get.mediaQuery.size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _addImageBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addImageBox() {
    return Container(
      width: Get.mediaQuery.size.width,
      height: 300,
      color: Colors.grey[200],
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 100,
      ),
    );
  }
}
