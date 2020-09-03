import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class PositionController extends GetxController {
  static PositionController get to => Get.find();

  Location _locationService;

  PositionController() : _locationService = Location();

  Rx<LatLng> latLng = Rx<LatLng>();

  @override
  void onReady() {
    super.onReady();
    _locationService.getLocation().then(
        (value) => this.latLng.value = LatLng(value.latitude, value.longitude));
  }

  Future<void> refreshLocation() async {
    final LocationData location = await _locationService.getLocation();

    this.latLng.value = LatLng(location.latitude, location.longitude);
  }
}
