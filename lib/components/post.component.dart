import 'package:boba_time/components/card.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostComponent extends StatelessWidget {
  String _username = 'Stephen';
  String bobaShop = 'Boba 1';

  @override
  Widget build(BuildContext context) {
    return CardComponent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _postHeader(),
          SizedBox(
            height: 15,
          ),
          _postPhoto(),
          SizedBox(
            height: 15,
          ),
          _postText(),
        ],
      ),
    );
  }

  Widget _postPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        'https://via.placeholder.com/400x400',
      ),
    );
  }

  Widget _postText() {
    return Text(
      'Lorem ipsum',
      style: Get.textTheme.bodyText2,
//      style: TextStyle(
//          fontFamily: AppThemes.secondaryFont,
//          fontWeight: FontWeight.normal,
//          fontSize: 14),
    );
  }

  Widget _postHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/140x100')),
            SizedBox(
              width: 20,
            ),
            Text(
              _username,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16),
            ),
          ],
        ),
        Text(
          bobaShop,
          style: TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
