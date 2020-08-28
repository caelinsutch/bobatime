import 'dart:convert';

import 'package:boba_time/components/boba-restaurant-card-component.dart';
import 'package:boba_time/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  static const String route = '/live_location';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController _mapController;
  LatLng currentLatLng;
  Location _location;
  http.Client client = http.Client();
  List<BobaShopModel> bobaShops;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _location = Location();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
        point: currentLatLng,
        builder: (ctx) => Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 7,
          height: 7,
        ),
      ),
    ];

    _getLocalBobaShops();

    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.
    return Scaffold(
        body: Stack(
      children: <Widget>[
        currentLatLng != null
            ? FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center:
                      LatLng(currentLatLng.latitude, currentLatLng.longitude),
                  zoom: 15.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // For example purposes. It is recommended to use
                    // TileProvider with a caching and retry strategy, like
                    // NetworkTileProvider or CachedNetworkTileProvider
                    tileProvider: NonCachingNetworkTileProvider(),
                  ),
                  MarkerLayerOptions(markers: markers)
                ],
              )
            : Container(),
        _bobaRestaurants(),
      ],
    ));
  }

  Widget _bobaRestaurants() {
    return Positioned(
      bottom: 0,
      child: Container(
          width: Get.mediaQuery.size.width,
          height: 300,
          child: this.bobaShops != null
              ? ListView(
                  scrollDirection: Axis.horizontal,
                  children: this
                      .bobaShops
                      .map((e) => BobaRestaurantCardComponent(
                            restaurantTitle: e.name,
                            restaurantRating: e.rating,
                            restaurantImage: e.imageUrl,
                          ))
                      .toList())
              : Container()),
    );
  }

  void _getUserLocation() {
    _location.getLocation().then((value) => this.setState(() {
          currentLatLng = LatLng(value.latitude, value.longitude);
        }));
  }

  void _getLocalBobaShops() {
    if (currentLatLng != null) {
      final latitude = currentLatLng.latitude;
      final longitude = currentLatLng.longitude;
      final yelpApiQueryUrl =
          'https://api.yelp.com/v3/businesses/search?term=boba&latitude=$latitude&longitude=$longitude';
      client.get(yelpApiQueryUrl, headers: {
        "Authorization":
            "Bearer qtAye-NJO_yvLrOVQgrc1-d2FtdzCc7R7J81_yNSvQvNbW8OSd6JS32qr9GdpsSy6UaFxPDH5ei_Jba5hxzz64SatNsi0IwmeT9-mG5ajaV2VA5EOkm8IKsLIi1AX3Yx"
      }).then((value) {
        final List data = jsonDecode(value.body)['businesses'];
        List<BobaShopModel> newBobaShops =
            data.map((e) => BobaShopModel.fromMap(e)).toList();
        this.setState(() {
          this.bobaShops = newBobaShops;
        });
      });
    }
  }
}
