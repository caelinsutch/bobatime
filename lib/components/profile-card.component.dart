import 'package:boba_time/components/card.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCardSearchComponent extends StatelessWidget {
  final bool isFollowed;

  ProfileCardSearchComponent({this.isFollowed = false});

  @override
  Widget build(BuildContext context) {
    return CardComponent(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://via.placeholder.com/400x400',
              width: Get.height / 15,
              height: Get.height / 15,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Joey Laderer',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          isFollowed
              ? OutlineButton(
                  child: Text('Unfollow'),
                  onPressed: () => print('Pressed'),
                  padding: EdgeInsets.all(0),
                  borderSide: BorderSide(
                    color: Get.theme.primaryColor, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 2, //width of the border
                  ),
                )
              : FlatButton(
                  child: Text('Follow'),
                  padding: EdgeInsets.all(0),
                  textColor: Colors.white,
                  color: Get.theme.primaryColor,
                  onPressed: () => print("Follow"),
                )
        ],
      ),
    );
  }
}
