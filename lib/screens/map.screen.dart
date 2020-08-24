import 'package:boba_time/components/boba-restaurant-card-component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  static const String route = '/live_location';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LocationData _currentLocation;
  MapController _mapController;

  bool _liveUpdate = true;
  bool _permission = false;

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
  }

  void initLocationService() async {
    try {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await _locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _locationService.requestService();
        if (!_serviceEnabled) {
          print('Error1');
        }
      }

      _permissionGranted = await _locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Error');
        }
      }

      _locationService
          .getLocation()
          .then((value) => this.setState(() {
                _currentLocation = value;
              }))
          .catchError((e) => print(e));
      _locationService.onLocationChanged.listen((LocationData result) async {
        if (mounted) {
          setState(() {
            _currentLocation = result;
            if (_liveUpdate) {
              _mapController.move(
                  LatLng(_currentLocation.latitude, _currentLocation.longitude),
                  _mapController.zoom);
            }
          });
        }
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;

    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.
    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation.latitude, _currentLocation.longitude);
    } else {
      currentLatLng = LatLng(0, 0);
    }

    var markers = <Marker>[
      Marker(
        point: currentLatLng,
        builder: (ctx) => Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 10,
          height: 10,
        ),
      ),
    ];

    return Scaffold(
        body: Stack(
      children: <Widget>[
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: LatLng(currentLatLng.latitude, currentLatLng.longitude),
            zoom: 5.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              // For example purposes. It is recommended to use
              // TileProvider with a caching and retry strategy, like
              // NetworkTileProvider or CachedNetworkTileProvider
              tileProvider: NonCachingNetworkTileProvider(),
            ),
            MarkerLayerOptions(markers: markers)
          ],
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: Get.mediaQuery.size.width,
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                BobaRestaurantCardComponent(
                  restaurantTitle: 'Boba 2',
                  restaurantRating: 2,
                ),
                BobaRestaurantCardComponent(
                  restaurantTitle: 'Boba 2',
                  restaurantRating: 2,
                ),
                BobaRestaurantCardComponent(
                  restaurantTitle: 'Boba 2',
                  restaurantRating: 2,
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
