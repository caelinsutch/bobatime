import 'package:boba_time/components/card.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCardSearchComponent extends StatelessWidget {
  bool _isFollowed = false;

  ProfileCardSearchComponent(this._isFollowed);

  @override
  Widget build(BuildContext context) {
    return CardComponent(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://via.placeholder.com/400x400',
              width: 75,
              height: 75,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Joey Laderer',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          _isFollowed
              ? OutlineButton(
                  child: Text('Unfollow'),
                  onPressed: () => print('Pressed'),
                  borderSide: BorderSide(
                    color: Get.theme.primaryColor, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 2, //width of the border
                  ),
                )
              : FlatButton(
                  child: Text('Follow'),
                  textColor: Colors.white,
                  color: Get.theme.primaryColor,
                  onPressed: () => print("Follow"),
                )
        ],
      ),
    );
  }
}
