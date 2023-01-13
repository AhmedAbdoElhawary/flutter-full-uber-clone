import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/data/models/place_location_info/place_location_info.dart';

class MapLogic extends GetxController {
  final Rx<Position?> _position = Rxn<Position?>();
  final Rx<Completer> mapController = Completer().obs;
  RxBool showLocationIcon = false.obs;
  Rx<Set<Marker>> travelMarkers = Rx<Set<Marker>>({});
  RxBool showSearchDestinationWidgets=false.obs;

  Rx<CameraPosition> get _myCurrentLocationCameraPosition => CameraPosition(
        bearing: 0.0,
        target:
            LatLng(getCurrentPosition!.latitude, getCurrentPosition!.longitude),
        tilt: 0.0,
        zoom: 17,
      ).obs;

  Position? get getCurrentPosition => _position.value;
  Completer get getMapController => mapController.value;
  CameraPosition get getMyCurrentLocationCameraPosition =>
      _myCurrentLocationCameraPosition.value;

  @override
  Future<void> onInit() async {
    await _getMyCurrentLocation();
    super.onInit();
  }

  void showSearchDestinationPage(){
    showSearchDestinationWidgets.value=true;
    update(["update"]);
  }
  changeShowingIcon(bool show) {
    showLocationIcon.value = show;
    update(["2"]);
  }

  Future<void> goToThisPosition(List<PlaceLocationInfo> positions) async {
    if (positions.length < 2) return;
    List<double> newPosition = _getMediumPositionOfLocations(positions);
    CameraPosition newPos = _getCameraPosition(newPosition[0], newPosition[1]);
    final GoogleMapController controller = await mapController.value.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(newPos));
    buildTravelPlacesMarkers(positions);
    update(["update"]);
  }

  List<double> _getMediumPositionOfLocations(
      List<PlaceLocationInfo> positions) {
    double latMediumPoint = 0, lngMediumPoint = 0;
    int i = 0;
    for (; i < positions.length; i++) {
      Location? p = positions[i].result?.geometry?.location;
      if (p == null || p.lat == null || p.lng == null) return [];

      latMediumPoint = p.lat!;
      lngMediumPoint = p.lng!;
    }

    return [latMediumPoint, lngMediumPoint];
  }

  CameraPosition _getCameraPosition(double lat, double lng) {
    return CameraPosition(
        bearing: 0.0, target: LatLng(lat, lng), tilt: 0.0, zoom: 17);
  }

  void buildTravelPlacesMarkers(List<PlaceLocationInfo> positions) {
    for (int i = 0; i < positions.length; i++) {
      PlaceLocationInfo position = positions[i];
      Location? p = position.result?.geometry?.location;
      if (p == null || p.lat == null || p.lng == null) return;

      Marker marker = Marker(
        position: LatLng(p.lat!, p.lng!),
        markerId: MarkerId("$i"),
        onTap: () {},
        infoWindow: InfoWindow(title: "$i" * 10),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );

      travelMarkers.value.add(marker);
    }
  }

  Future<void> goToMyCurrentLocation() async {
    final GoogleMapController controller = await mapController.value.future;
    await controller.animateCamera(
        CameraUpdate.newCameraPosition(getMyCurrentLocationCameraPosition));
  }

  Future<void> _getMyCurrentLocation() async {
    _position.value = await _getCurrentLocation();
    update(["small map id"]);
  }

  static Future<Position> _getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition();
  }
}
