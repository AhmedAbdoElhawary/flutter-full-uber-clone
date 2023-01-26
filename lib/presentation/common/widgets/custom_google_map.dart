import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/data/models/places_direction/places_direction.dart';
import 'package:uber/presentation/cubit/google_map_cubit/places_suggestions_cubit.dart';
import 'package:uber/presentation/cubit/google_map_cubit/result_state.dart';
import 'package:uber/presentation/pages/map/logic/map_logic.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap(
      {this.tag = "small map tag", this.id = "small map id", super.key});
  final String tag;
  final String id;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapLogic>(
      id: id,
      tag: tag,
      initState: (state) {
        if (tag == "small map tag") {
          Get.put<MapLogic>(MapLogic(), tag: tag);
        } else {
          Get.find<MapLogic>(tag: tag);
        }
      },
      builder: (MapLogic mapControl) {
        switch (mapControl.getCurrentPosition) {
          case null:
            return const _GrayContainer();
          default:
            return _BuildGoogleMap(mapControl);
        }
      },
    );
  }
}

class _BuildGoogleMap extends StatelessWidget {
  final MapLogic mapControl;
  const _BuildGoogleMap(
    this.mapControl, {
    Key? key,
  }) : super(key: key);

  void _onPointerDown(PointerDownEvent details) {
    if (!mapControl.showLocationIcon.value) {
      mapControl.changeShowingIcon(true);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    try {
      mapControl.mapController.value.complete(controller);
    } catch (e) {
      rethrow;
    }
  }

  List<LatLng> getPolyLinesPoints(PlacesDirection placesDirectionInfo) {
    List<PointLatLng> latLngPoints =placesDirectionInfo.polylinePoints;
    List<LatLng> polyLines =
        latLngPoints.map((e) => LatLng(e.latitude, e.longitude)).toList();
    return polyLines;
  }

  Set<Polyline> getPolyLines(ResultState state) {
    switch (state is PlacesDirectionLoaded) {
      case true:
        return {
          Polyline(
            polylineId: const PolylineId("p"),
            color: Colors.black,
            width: 2,
            points: state.maybeWhen(
              placesDirectionLoaded: (dirInfo) => getPolyLinesPoints(dirInfo),
              orElse: () => [],
            ),
          ),
        };
      default:
        return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      child: BlocBuilder<GoogleMapCubit, ResultState>(
        builder: (context, state) {
          return GoogleMap(
            markers: mapControl.travelMarkers.value,
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            compassEnabled:false,
            mapToolbarEnabled:false,
            // tiltGesturesEnabled:false,
            initialCameraPosition:
                mapControl.getMyCurrentLocationCameraPosition,
            onMapCreated: _onMapCreated,
            polylines: getPolyLines(state),
          );
        },
      ),
    );
  }
}

class _GrayContainer extends StatelessWidget {
  const _GrayContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ColorManager.lowOpacityGrey,
    );
  }
}
