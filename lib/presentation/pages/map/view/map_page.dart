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
import 'package:uber/presentation/pages/search_destination/view/search_destination_page.dart';

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
              mapControl.getCurrentPosition != null
                  ? buildScreen(mapControl)
                  : const Center(
                      child: ThineCircularProgress(color: ColorManager.blue)),
              const BackButton(),
            ],
          ),
        ),
      ),
    );
  }

  Column buildScreen(MapLogic mapControl) {
    return Column(
      children: [
        Flexible(child: MapDisplay(mapControl: mapControl)),
        const SearchContainer(),
      ],
    );
  }
}

class MapDisplay extends StatelessWidget {
  const MapDisplay({Key? key, required this.mapControl}) : super(key: key);

  final MapLogic mapControl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomGoogleMap(mapControl: mapControl),
        const Align(alignment: Alignment.bottomRight, child: MyLocationIcon())
      ],
    );
  }
}

class SearchContainer extends StatelessWidget {
  const SearchContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      decoration: BoxDecoration(color: ColorManager.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 6,
          blurRadius: 9,
          offset: const Offset(0, 4),
        ),
      ]),
      width: double.infinity,
      child: Padding(
        padding: REdgeInsets.only(left: 15, right: 15, bottom: 60, top: 15),
        child: GestureDetector(
          onTap: () {
            Go.to(SearchDestinationPage());
          },
          child: Container(
            width: double.infinity,
            height: 20.h,
            color: ColorManager.veryLowOpacityGrey,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: REdgeInsetsDirectional.only(start: 15),
                  child: const Text("Search destination"),
                )),
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 35, horizontal: 15),
        child: GestureDetector(
          onTap: () => Go.back(),
          child: const _ContainerWithBoxShadow(
            child: Icon(Icons.arrow_back, size: 25),
          ),
        ),
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
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 4,
          blurRadius: 5,
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
          if (makeIconAppear) animateLocationIcon(true);

          return Padding(
            padding: REdgeInsets.symmetric(vertical: 35, horizontal: 15),
            child: ScaleTransition(
              scale: _animation,
              child: GestureDetector(
                onTap: () async {
                  await mapController.goToMyCurrentLocation();

                  await animateLocationIcon(false);
                  mapController.changeShowingIcon(false);
                },
                child: _ContainerWithBoxShadow(
                  child: SvgPicture.asset(IconsAssets.myLocation, height: 25),
                ),
              ),
            ),
          );
        });
  }

  Future<void> animateLocationIcon(bool show) async {
    if (show) {
      await _controller.animateBack(
        1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      await _controller.animateBack(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
