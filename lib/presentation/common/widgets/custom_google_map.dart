import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/presentation/pages/map/logic/map_logic.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({required this.mapControl, super.key});
  final MapLogic mapControl;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (mapControl.getCurrentPosition != null) {
          return Listener(
            onPointerDown: (PointerDownEvent details) {
              if (!mapControl.showLocationIcon.value) {
                mapControl.changeShowingIcon(true);
              }
            },
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition:
                  mapControl.getMyCurrentLocationCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                try {
                  mapControl.mapController.value.complete(controller);
                } catch (e) {
                  NullThrownError;
                }
              },
            ),
          );
        } else {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: ColorManager.lowOpacityGrey,
          );
        }
      },
    );
  }
}
