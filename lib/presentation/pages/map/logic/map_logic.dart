import 'dart:async';
import 'dart:math';

import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/core/resources/strings_manager.dart';
import 'package:uber/data/models/place_location_info/place_location_info.dart';
import 'package:uber/presentation/cubit/google_map_cubit/places_suggestions_cubit.dart';

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

  Future<void> preparePlacesDirection(
      BuildContext context, List<PlaceLocationInfo> placesLocationInfo) async {
    // TODO: start and end points only
    Location? startLatLng = placesLocationInfo[0].result?.geometry?.location;
    Location? endLatLng = placesLocationInfo[1].result?.geometry?.location;
    if (startLatLng == null || endLatLng == null) return;
    String startP = '${startLatLng.lat},${startLatLng.lng}';
    String endP = '${endLatLng.lat},${endLatLng.lng}';
    await GoogleMapCubit.get(context)
        .getPlacesDirection(startPoint: startP, endPoint: endP);
  }

  Future<void> goToThosePositions(
      BuildContext context, List<PlaceLocationInfo> positions) async {
    if (positions.length < 2) return;
    _MiddleCameraPosition? middleCameraPos =
        _getCenterPositionOfLocations(positions);
    if (middleCameraPos == null) return;
    CameraPosition newPos = _getCameraPosition(middleCameraPos);
    _buildTravelPlacesMarkers(context, positions);
    final GoogleMapController controller = await mapController.value.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(newPos));
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

      latMediumPoint += p.lat!;
      lngMediumPoint += p.lng!;

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

  Future<void> _buildTravelPlacesMarkers(
      BuildContext context, List<PlaceLocationInfo> positions) async {
    final BitmapDescriptor startIcon = await MarkerIcon.svgAsset(
        assetName: 'assets/icons/circle.svg', context: context, size: 12);

    final endIcon = await MarkerIcon.svgAsset(
        assetName: 'assets/icons/square.svg', context: context, size: 12);

    _buildMarkers(startIcon, endIcon, positions);
  }

  Future<void> _buildMarkers(BitmapDescriptor startIcon,
      BitmapDescriptor endIcon, List<PlaceLocationInfo> positions) async {
    for (int i = 0; i < positions.length; i++) {
      PlaceLocationInfo position = positions[i];
      Location? p = position.result?.geometry?.location;
      if (p == null || p.lat == null || p.lng == null) return;
      String mainText =
          position.placeSubTextInfo?.mainText ?? StringsManager.somethingWrong;

      Marker marker = Marker(
        position: LatLng(p.lat!, p.lng!),
        markerId: MarkerId("$i"),
        onTap: () {},
        infoWindow: InfoWindow(title: mainText),
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
