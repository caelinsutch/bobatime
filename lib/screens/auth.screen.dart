import 'package:boba_time/constants/constants.dart';
import 'package:boba_time/controllers/controllers.dart';
import 'package:boba_time/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
      backgroundColor: CustomColors.main,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset('assets/boba.svg'),
            SizedBox(
              height: 70,
            ),
            Center(
              child: Text(
                'BOBATIME',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 62,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            RaisedButton(
              color: Colors.white,
              textColor: AppThemes.bobaGreen,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset('assets/google-logo.svg'),
                    SizedBox(width: 20),
                    Text(
                      'Login with Google',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                authController.signInWithGoogle();
              },
            ),
            SizedBox(
              height: 50,
            ),
          ]),
    );
  }
}
