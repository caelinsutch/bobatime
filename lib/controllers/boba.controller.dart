import 'dart:convert';

import 'package:boba_time/models/models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class BobaYelpController extends GetxController {
  static BobaYelpController get to => Get.find();
  http.Client client = http.Client();
  Location _location = Location();

  Rx<LatLng> latLng = Rx<LatLng>();

  @override
  void onReady() async {
    super.onInit();
    _location.getLocation().then(
        (value) => latLng.value = LatLng(value.latitude, value.longitude));
  }

  Future<List<BobaShopModel>> getBobaShops(
      double latitude, double longitude) async {
    final yelpApiQueryUrl =
        'https://api.yelp.com/v3/businesses/search?term=boba&latitude=$latitude&longitude=$longitude';
    final value = await client.get(yelpApiQueryUrl, headers: {
      "Authorization":
          "Bearer qtAye-NJO_yvLrOVQgrc1-d2FtdzCc7R7J81_yNSvQvNbW8OSd6JS32qr9GdpsSy6UaFxPDH5ei_Jba5hxzz64SatNsi0IwmeT9-mG5ajaV2VA5EOkm8IKsLIi1AX3Yx"
    });
    final List data = jsonDecode(value.body)['businesses'];
    List<BobaShopModel> newBobaShops =
        data.map((e) => BobaShopModel.fromMap(e)).toList();
    return newBobaShops;
  }
}
