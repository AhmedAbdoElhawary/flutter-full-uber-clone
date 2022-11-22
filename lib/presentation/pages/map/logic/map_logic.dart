import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLogic extends GetxController {
  final Rx<Position?> _position = Rxn<Position?>();
  final Rx<Completer> mapController = Completer().obs;
  Rx<CameraPosition> get _myCurrentLocationCameraPosition => CameraPosition(
        bearing: 0.0,
        target:
            LatLng(getCurrentPosition!.latitude, getCurrentPosition!.longitude),
        tilt: 0.0,
        zoom: 17,
      ).obs;

  @override
  Future<void> onInit() async {
    await getMyCurrentLocation();
    super.onInit();
  }

  Position? get getCurrentPosition => _position.value;
  Completer get getMapController => mapController.value;
  CameraPosition get getMyCurrentLocationCameraPosition =>
      _myCurrentLocationCameraPosition.value;

  void setCurrentPosition(Position p) => _position.value = p;

  RxBool showLocationIcon = false.obs;
  changeShowingIcon(bool show) {
    showLocationIcon.value = show;
    update(["2"]);
  }

  static Future<Position> _getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition();
  }

  Future<void> goToMyCurrentLocation() async {
    final GoogleMapController controller = await mapController.value.future;
    await controller.animateCamera(
        CameraUpdate.newCameraPosition(getMyCurrentLocationCameraPosition));
  }

  Future<void> getMyCurrentLocation() async {
    _position.value = await _getCurrentLocation();
  }
}
