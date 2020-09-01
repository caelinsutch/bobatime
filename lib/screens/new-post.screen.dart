import 'package:boba_time/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  TextEditingController _descriptionEditingController = TextEditingController();

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
          child: ListView(
            children: <Widget>[
              _addImageBox(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Description',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              _descriptionBox(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Boba Shop',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              _bobaRestaurantPicker(),
              SizedBox(
                height: 20,
              ),
              _postButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _addImageBox() {
    return Container(
      width: Get.mediaQuery.size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.grey[200],
      ),
      height: 300,
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 100,
      ),
    );
  }

  Widget _descriptionBox() {
    return TextField(
        decoration: InputDecoration(
          hintText: "Description",
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.white,
          filled: true,
        ),
        style: TextStyle(color: Colors.blueGrey),
        controller: _descriptionEditingController,
        keyboardType: TextInputType.multiline,
        maxLines: 5);
  }

  Widget _bobaRestaurantPicker() {
    return TextField(
      decoration: InputDecoration(
          hintText: "Boba Shop",
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.search)),
    );
  }

  Widget _postButton() {
    return FlatButton(
      color: Colors.white,
      textColor: AppThemes.bobaGreen,
      child: Text(
        'Get Directions',
      ),
      onPressed: () => print('Directions'),
    );
  }
}
