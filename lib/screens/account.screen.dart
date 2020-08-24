import 'package:boba_time/constants/constants.dart';
import 'package:boba_time/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final bool isUsersAccount = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[topSection()],
    );
  }

  Widget topSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Image
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://via.placeholder.com/400x400',
                width: 100,
                height: 100,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Joey Lader',
                style: Get.textTheme.headline6,
              ),
              SizedBox(
                height: 15,
              ),
              this.isUsersAccount
                  ? Row(
                      children: <Widget>[
                        OutlineButton(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(fontSize: 12),
                          ),
                          padding: EdgeInsets.all(0),
                          onPressed: () => print('Pressed'),
                          borderSide: BorderSide(
                            color: Get.theme.primaryColor, //Color of the border
                            style: BorderStyle.solid, //Style of the border
                            width: 2, //width of the border
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton(
                            child: Text(
                              'Log Out',
                              style: TextStyle(fontSize: 12),
                            ),
                            padding: EdgeInsets.all(0),
                            textColor: Colors.white,
                            color: AppThemes.bobaGreen,
                            onPressed: () => _authController.signOut()),
                      ],
                    )
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}
