import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  Widget child;
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry margin;

  CardComponent({this.child, this.padding = const EdgeInsets.all(20), this.margin = const EdgeInsets.all(20)});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: padding,
        child: child,
      ),
      margin: margin,
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
