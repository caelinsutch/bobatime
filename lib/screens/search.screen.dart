import 'package:boba_time/components/components.dart';
import 'package:boba_time/controllers/controllers.dart';
import 'package:boba_time/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final BobaYelpController _bobaYelpController = Get.find();
  final PositionController _positionController = Get.find();
  List<BobaShopModel> _bobaShops;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bobaYelpController
        .getBobaShopsWithSavedMarked(
      latitude: _positionController.latLng.value.latitude,
      longitude: _positionController.latLng.value.longitude,
    )
        .then((value) {
      this.setState(() {
        this._bobaShops = value;
      });
    });
  }

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
              onChanged: (value) {
                _bobaYelpController
                    .getBobaShopsWithSavedMarked(
                        latitude: _positionController.latLng.value.latitude,
                        longitude: _positionController.latLng.value.longitude,
                        searchTerm: 'boba ' + value)
                    .then((value) {
                  this.setState(() {
                    this._bobaShops = value;
                  });
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text('Boba'),
            this._bobaShopWidgets(),
            Text('People'),
            Container(
              width: Get.mediaQuery.size.width,
              height: Get.mediaQuery.size.height * .28,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ProfileCardSearchComponent(
                    isFollowed: true,
                  ),
                  ProfileCardSearchComponent(
                    isFollowed: false,
                  ),
                  ProfileCardSearchComponent(
                    isFollowed: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bobaShopWidgets() {
    return Container(
      width: Get.mediaQuery.size.width,
      height: Get.mediaQuery.size.height * .32,
      child: this._bobaShops != null
          ? ListView(
              scrollDirection: Axis.horizontal,
              children: this
                  ._bobaShops
                  .map((e) => BobaRestaurantCardComponent(
                        restaurantTitle: e.name,
                        restaurantRating: e.rating,
                        saved: e.isSaved,
                        onSavedSwitch: (saved) => null,
                        restaurantImage: e.imageUrl,
                      ))
                  .toList(),
            )
          : Container(),
    );
  }
}
