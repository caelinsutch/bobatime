import 'package:boba_time/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search for people or boba...',
                  prefixIcon: Icon(Icons.search)),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Boba'),
            Container(
              width: Get.mediaQuery.size.width,
              height: Get.mediaQuery.size.height * .32,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  BobaRestaurantCardComponent(
                    restaurantRating: 4,
                    restaurantTitle: 'Boba 1',
                  ),
                  BobaRestaurantCardComponent(
                    restaurantRating: 4,
                    restaurantTitle: 'Boba 1',
                  ),
                  BobaRestaurantCardComponent(
                    restaurantRating: 4,
                    restaurantTitle: 'Boba 1',
                  ),
                ],
              ),
            ),
            Text('People'),
            Container(
              width: Get.mediaQuery.size.width,
              height: Get.mediaQuery.size.height * .28,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProfileCardSearchComponent(false),
                  ProfileCardSearchComponent(true),
                  ProfileCardSearchComponent(true),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
