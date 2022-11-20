import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLogic extends GetxController {
  Rx<Position?> position = Rxn<Position?>();
  Rx<Completer> mapController = Completer().obs;
  Rx<CameraPosition> get myCurrentLocationCameraPosition => CameraPosition(
        bearing: 0.0,
        target: LatLng(position.value!.latitude, position.value!.longitude),
        tilt: 0.0,
        zoom: 17,
      ).obs;
  final RxBool showLocationIcon = false.obs;
   changeShowingIcon(bool show) {
    showLocationIcon.value = show;
    update(["2"]);
  }

  @override
  Future<void> onInit() async {
    await getMyCurrentLocation();

    super.onInit();
  }

  static Future<Position> _getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition();
  }

  Future<void> goToMyCurrentLocation() async {
    final GoogleMapController controller = await mapController.value.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(myCurrentLocationCameraPosition.value));
  }

  Future<void> getMyCurrentLocation() async {
    position.value = await _getCurrentLocation();
  }
}
