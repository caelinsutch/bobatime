import 'package:flutter/material.dart';

class ProfileImageComponent extends StatelessWidget {
  String imageUrl;
  double width;
  double height;

  ProfileImageComponent(
      {@required this.imageUrl, this.width = 100, this.height = 100});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: imageUrl != null
            ? Image.network(
                imageUrl,
                width: width,
                height: height,
                fit: BoxFit.cover,
              )
            : Container());
  }
}
