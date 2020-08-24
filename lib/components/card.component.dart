import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  Widget child;

  CardComponent({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(30, 0, 0, 0),
            offset: Offset(0, 2),
            blurRadius: 25,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
