import 'dart:convert';

import 'package:boba_time/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BobaYelpController extends GetxController {
  static BobaYelpController get to => Get.find();
  http.Client client = http.Client();

  final _yelpAuthHeader = {
    "Authorization":
        "Bearer qtAye-NJO_yvLrOVQgrc1-d2FtdzCc7R7J81_yNSvQvNbW8OSd6JS32qr9GdpsSy6UaFxPDH5ei_Jba5hxzz64SatNsi0IwmeT9-mG5ajaV2VA5EOkm8IKsLIi1AX3Yx"
  };

  Future<List<BobaShopModel>> getBobaShops(
      {@required double latitude,
      @required double longitude,
      String searchTerm = 'boba'}) async {
    final encodedSearchTerm = searchTerm
        .replaceAll('&', '')
        .split(" ")
        .join('+'); // Remove spaces and replace with + signs
    final yelpApiQueryUrl =
        'https://api.yelp.com/v3/businesses/search?term=$encodedSearchTerm&latitude=$latitude&longitude=$longitude';
    final value = await client.get(yelpApiQueryUrl, headers: _yelpAuthHeader);
    final List data = jsonDecode(value.body)['businesses'];
    List<BobaShopModel> newBobaShops =
        data.map((e) => BobaShopModel.fromMap(e)).toList();
    return newBobaShops;
  }
}
