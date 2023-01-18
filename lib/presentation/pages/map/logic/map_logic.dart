import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/data/models/place_location_info/place_location_info.dart';
import 'package:uber/data/models/place_suggestion/places_suggestions.dart';

class _MiddleCameraPosition {
  double latPoint;
  double lngPoint;
  double zoom;
  _MiddleCameraPosition({
    required this.latPoint,
    required this.lngPoint,
    this.zoom = 25.0,
  });
}

class _MiddleLatLngDetails {
  double latPoint;
  double lngPoint;
  double maxLatPoint;
  double minLatPoint;

  _MiddleLatLngDetails({
    required this.latPoint,
    required this.lngPoint,
    required this.minLatPoint,
    required this.maxLatPoint,
  });
}

class MapLogic extends GetxController {
  final Rx<Position?> _position = Rxn<Position?>();
  final Rx<Completer> mapController = Completer().obs;
  RxBool showLocationIcon = false.obs;
  Rx<Set<Marker>> travelMarkers = Rx<Set<Marker>>({});
  RxBool showSearchDestinationWidgets = false.obs;

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

  void showSearchDestinationPage() {
    showSearchDestinationWidgets.value = true;
    update(["update"]);
  }

  changeShowingIcon(bool show) {
    showLocationIcon.value = show;
    update(["2"]);
  }

  Future<void> goToThosePositions(List<PlaceLocationInfo> positions) async {
    if (positions.length < 2) return;
    _MiddleCameraPosition? middleCameraPos =
        _getCenterPositionOfLocations(positions);
    if (middleCameraPos == null) return;
    CameraPosition newPos = _getCameraPosition(middleCameraPos);
    final GoogleMapController controller = await mapController.value.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(newPos));
    buildTravelPlacesMarkers(positions);
    update(["update"]);
  }

  _MiddleCameraPosition? _getCenterPositionOfLocations(
      List<PlaceLocationInfo> positions) {
    _MiddleLatLngDetails? middleLatLngPoints =
        _getMiddleOfLatLngPoints(positions);
    if (middleLatLngPoints == null) return null;

    double zoomOut = _calZoomOutOfThisPosition(middleLatLngPoints);
    return _MiddleCameraPosition(
      lngPoint: middleLatLngPoints.lngPoint,
      latPoint: middleLatLngPoints.latPoint,
      zoom: zoomOut,
    );
  }

  _MiddleLatLngDetails? _getMiddleOfLatLngPoints(
      List<PlaceLocationInfo> positions) {
    double latMediumPoint = 0,
        lngMediumPoint = 0,
        maxLatPoint = 0,
        minLatPoint = double.maxFinite;

    int i = 0;
    for (; i < positions.length; i++) {
      Location? p = positions[i].result?.geometry?.location;
      if (p == null || p.lat == null || p.lng == null) return null;

      latMediumPoint = p.lat!;
      lngMediumPoint = p.lng!;

      double abs = (p.lat! - p.lng!).abs();

      minLatPoint = min(minLatPoint, abs);
      maxLatPoint = max(maxLatPoint, abs);
    }

    return _MiddleLatLngDetails(
      latPoint: latMediumPoint / i,
      lngPoint: lngMediumPoint / i,
      maxLatPoint: maxLatPoint,
      minLatPoint: minLatPoint,
    );
  }

  double _calZoomOutOfThisPosition(_MiddleLatLngDetails latLngDetails) {
    // double minLatPoint = latLngDetails.minLatPoint;
    // double maxLatPoint = latLngDetails.maxLatPoint;
    // double def = minLatPoint - maxLatPoint;
    return 25.0;
  }

  CameraPosition _getCameraPosition(_MiddleCameraPosition pos) {
    return CameraPosition(
      target: LatLng(pos.latPoint, pos.lngPoint),
      zoom: pos.zoom,
      bearing: 0.0,
      tilt: 0.0,
    );
  }

  Future<void> buildTravelPlacesMarkers(
      List<PlaceLocationInfo> positions) async {
    ImageConfiguration imageConf = const ImageConfiguration(size: Size(25, 25));
    BitmapDescriptor startIcon = await BitmapDescriptor.fromAssetImage(
        imageConf, 'assets/icons/circle.png');
    BitmapDescriptor endIcon = await BitmapDescriptor.fromAssetImage(
        imageConf, 'assets/icons/square.png');

    for (int i = 0; i < positions.length; i++) {
      PlaceLocationInfo position = positions[i];
      Location? p = position.result?.geometry?.location;
      if (p == null || p.lat == null || p.lng == null) return;
      StructuredFormatting? placeSubDetails = position.placeSubTextInfo;
      String errorText =
          "there is something wrong with placeSubTextInfo of position";
      String mainText = placeSubDetails?.mainText ?? errorText;
      String secondaryText = placeSubDetails?.secondaryText ?? errorText;

      Marker marker = Marker(
        position: LatLng(p.lat!, p.lng!),
        markerId: MarkerId("$i"),
        onTap: () {},
        infoWindow: InfoWindow(title: "$mainText, $secondaryText"),
        icon: i == 0 ? startIcon : endIcon,
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
