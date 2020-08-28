import 'package:boba_time/components/boba-restaurant-card-component.dart';
import 'package:boba_time/controllers/boba.controller.dart';
import 'package:boba_time/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController _mapController;
  LatLng currentLatLng;
  List<BobaShopModel> bobaShops;
  final BobaYelpController _bobaYelpController = Get.find();
  List<Marker> bobaShopMarkers = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    this.currentLatLng = LatLng(_bobaYelpController.latLng.value.latitude,
        _bobaYelpController.latLng.value.longitude);
  }

  @override
  Widget build(BuildContext context) {
    _getLocalBobaShops();
    this.bobaShopMarkers.add(Marker(
          point: currentLatLng,
          builder: (ctx) => Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            width: 7,
            height: 7,
          ),
        ));
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
                  zoom: 12.0,
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
                  MarkerLayerOptions(markers: bobaShopMarkers)
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

  void _getLocalBobaShops() {
    if (currentLatLng != null) {
      final latitude = currentLatLng.latitude;
      final longitude = currentLatLng.longitude;
      _bobaYelpController
          .getBobaShops(latitude, longitude)
          .then((value) => this.setState(() {
                this.bobaShops = value;
                this.bobaShops.forEach((element) {
                  bobaShopMarkers.add(Marker(
                    point: LatLng(element.coordinates.latitude,
                        element.coordinates.longitude),
                    builder: (ctx) => Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 7,
                      height: 7,
                    ),
                  ));
                });
              }));
    }
  }
}
