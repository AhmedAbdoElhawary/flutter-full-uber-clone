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
  @override
  Future<void> onInit() async {
    await getMyCurrentLocation();

    super.onInit();
  }

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
        CameraUpdate.newCameraPosition(myCurrentLocationCameraPosition.value));
  }

  Future<void> getMyCurrentLocation() async {
    position.value = await _getCurrentLocation();
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:uber/config/routes/route_app.dart';
// import 'package:uber/core/resources/assets_manager.dart';
// import 'package:uber/core/resources/color_manager.dart';
// import 'package:uber/presentation/common_widgets/custom_circulars_progress.dart';
// import 'package:uber/presentation/common_widgets/custom_google_map.dart';
// import 'package:uber/presentation/pages/map/logic/map_page_logic.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
//   late AnimationController _controller;

//   late Animation<double> _animation;
//   @override
//   void initState() {
//     _controller = AnimationController(
//         duration: const Duration(microseconds: 500), vsync: this)
//       ..forward();
//     _animation =
//         CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     MapLogic mapController = Get.put(MapLogic(), tag: '2');
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.dark),
//       child: Scaffold(
//         body: Obx(
//           () => Stack(
//             fit: StackFit.expand,
//             children: [
//               mapController.position.value != null
//                   ? CustomGoogleMap(
//                       mapControl: mapController,
//                       onCameraMovedVoidCallback: appearLocationIcon,
//                     )
//                   : const Center(
//                       child: ThineCircularProgress(color: ColorManager.blue)),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: REdgeInsets.symmetric(vertical: 35, horizontal: 20),
//                   child: GestureDetector(
//                     onTap: () => Go.back(),
//                     child: const _ContainerWithBoxShadow(
//                       child: Icon(Icons.arrow_back, size: 25),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: ScaleTransition(
//           scale: _animation,
//           child: GestureDetector(
//             onTap: () async {
//               mapController.showLocationIcon.value = false;
//               await mapController.goToMyCurrentLocation();
//               await appearLocationIcon(false);
//               await Future.delayed(const Duration(seconds: 1));
//               mapController.showLocationIcon.value = true;
//             },
//             child: _ContainerWithBoxShadow(
//               child: SvgPicture.asset(IconsAssets.myLocation, height: 25),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> appearLocationIcon(bool show) async {
//     if (show) {
//       await _controller.animateTo(
//         1,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.fastOutSlowIn,
//       );
//     } else {
//       await _controller.animateBack(
//         0,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.fastOutSlowIn,
//       );
//     }
//   }
// }

// class _ContainerWithBoxShadow extends StatelessWidget {
//   final Widget child;
//   const _ContainerWithBoxShadow({required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.2),
//           spreadRadius: 3,
//           blurRadius: 4,
//           offset: Offset.fromDirection(0),
//         ),
//       ], shape: BoxShape.circle, color: ColorManager.white),
//       padding: REdgeInsets.all(10),
//       child: child,
//     );
//   }
// }
