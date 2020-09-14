import 'package:boba_time/components/components.dart';
import 'package:boba_time/controllers/controllers.dart';
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
  LatLng _currentLatLng;
  List<BobaShopModel> _bobaShops;
  List<BobaShopModel> _savedBobaShops;
  final PositionController _positionController = Get.find();
  final BobaYelpController _bobaYelpController = Get.find();
  final UserController _userController = Get.find();
  List<Marker> _bobaShopMarkers = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    this._currentLatLng = LatLng(_positionController.latLng.value.latitude,
        _positionController.latLng.value.longitude);
    _getLocalBobaShops();
  }

  @override
  Widget build(BuildContext context) {
    this._bobaShopMarkers.add(Marker(
          point: _currentLatLng,
          width: 15,
          height: 15,
          builder: (ctx) => Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ));
    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _currentLatLng != null
            ? FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center:
                      LatLng(_currentLatLng.latitude, _currentLatLng.longitude),
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
                  MarkerLayerOptions(markers: _bobaShopMarkers)
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
          height: Get.mediaQuery.size.height * .35,
          child: this._bobaShops != null
              ? ListView(
                  scrollDirection: Axis.horizontal,
                  children: this
                      ._bobaShops
                      .map((e) => BobaRestaurantCardComponent(
                            restaurantTitle: e.name,
                            restaurantRating: e.rating,
                            restaurantImage: e.imageUrl,
                            saved: e.isSaved,
                    onSavedSwitch: (saved) => _saveBobaShop(e, saved),
                          ))
                      .toList())
              : Container()),
    );
  }

  void _saveBobaShop(BobaShopModel bobaShop, bool saved) async {
    this.setState(() {
      this._bobaShops = this._bobaShops.map((e) {
        if (e.name == bobaShop.name) {
          e.isSaved = !e.isSaved;
        }
        if (e.isSaved) {
          _userController.addSavedBobaPlace(e, _userController.firebaseUser.value.uid);
        } else {
          _userController.removeSavedBobaPlace(e, _userController.firebaseUser.value.uid);
        }
        return e;
      }).toList();
    });
  }

  void _getLocalBobaShops() async {
    if (_currentLatLng != null) {
      // Get the current user location
      final latitude = _currentLatLng.latitude;
      final longitude = _currentLatLng.longitude;
      // Call the Yelp API to get boba shops
      final List<BobaShopModel> newBobaShops = await _bobaYelpController
          .getBobaShops(latitude: latitude, longitude: longitude);

      this._bobaShops = newBobaShops;
      this._savedBobaShops = _userController.firestoreUser.value.favoriteBobaShops;
      this._bobaShops.map((e) {
        if (this._savedBobaShops.where(
                (element) => element.name == e.name).length != 0) {
          e.isSaved = true;
        }
      }).toList();

      this._bobaShops.forEach((element) {
        _createBobaShopMarker(
            element.coordinates.latitude, element.coordinates.longitude);
      });
    }
  }

  void _createBobaShopMarker(double latitude, double longitude) {
    this.setState(() {
      _bobaShopMarkers.add(Marker(
        point: LatLng(latitude, longitude),
        width: 10,
        height: 10,
        builder: (ctx) => Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ));
    });
  }
}
