import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/core/resources/color_manager.dart';
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
      builder: (mapControl) {
        switch (mapControl.getCurrentPosition) {
          case null:
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: ColorManager.lowOpacityGrey,
            );
          default:
            return Listener(
              onPointerDown: (PointerDownEvent details) {
                if (!mapControl.showLocationIcon.value) {
                  mapControl.changeShowingIcon(true);
                }
              },
              child: GoogleMap(
                markers: mapControl.travelMarkers.value,
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
        }
      },
    );
  }
}
