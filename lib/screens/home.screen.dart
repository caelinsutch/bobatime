import 'package:boba_time/components/components.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          PostComponent(),
        ],
      ),
    );
  }
}
