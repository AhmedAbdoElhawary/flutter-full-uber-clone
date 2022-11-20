import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/resources/assets_manager.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/presentation/common_widgets/custom_circulars_progress.dart';
import 'package:uber/presentation/common_widgets/custom_google_map.dart';
import 'package:uber/presentation/pages/map/logic/map_page_logic.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapLogic mapControl = Get.put(MapLogic(), tag: '2');
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Obx(
          () => Stack(
            fit: StackFit.expand,
            children: [
              mapControl.position.value != null
                  ? CustomGoogleMap(mapControl: mapControl)
                  : const Center(
                      child: ThineCircularProgress(color: ColorManager.blue)),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: REdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  child: GestureDetector(
                    onTap: () => Go.back(),
                    child: const _ContainerWithBoxShadow(
                      child: Icon(Icons.arrow_back, size: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: const MyLocationIcon(),
      ),
    );
  }
}

class _ContainerWithBoxShadow extends StatelessWidget {
  final Widget child;
  const _ContainerWithBoxShadow({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 3,
          blurRadius: 4,
          offset: Offset.fromDirection(0),
        ),
      ], shape: BoxShape.circle, color: ColorManager.white),
      padding: REdgeInsets.all(10),
      child: child,
    );
  }
}

class MyLocationIcon extends StatefulWidget {
  const MyLocationIcon({super.key});

  @override
  State<MyLocationIcon> createState() => _MyLocationIconState();
}

class _MyLocationIconState extends State<MyLocationIcon>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(microseconds: 500), vsync: this)
      ..forward();
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapLogic>(
        id: "2",
        tag: '2',
        builder: (mapController) {
          bool makeIconAppear = mapController.showLocationIcon.value;
          print("11111111111111111111111");
          if (makeIconAppear) {
            print("2222222222222222222222");

            animateLocationIcon(true);
          }

          return ScaleTransition(
            scale: _animation,
            child: GestureDetector(
              onTap: () async {
                // mapController.changeShowingIcon(false);
                setState(() {
                  _controller.animateBack(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                });

                await mapController.goToMyCurrentLocation();
              },
              child: _ContainerWithBoxShadow(
                child: SvgPicture.asset(IconsAssets.myLocation, height: 25),
              ),
            ),
          );
        });
  }

  animateLocationIcon(bool appear) {
    if (appear) {
      _controller.forward();
    } else {
      _controller.animateBack(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
