import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/presentation/common/widgets/custom_circulars_progress.dart';
import 'package:uber/presentation/common/widgets/custom_google_map.dart';
import 'package:uber/presentation/pages/map/logic/map_logic.dart';
import 'package:uber/presentation/pages/map/view/search_destination/search_destination_page.dart';
import 'package:uber/presentation/pages/map/widgets/map_widgets/circle_with_box_shadow.dart';
import 'package:uber/presentation/pages/map/widgets/map_widgets/location_icon.dart';

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
                      child: ThineCircularProgress(color: ColorManager.black)),
              const _BackButton(),
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
        const _SearchContainer(),
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
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: REdgeInsets.symmetric(vertical: 35, horizontal: 15),
              child: const MyLocationIcon(tag: "2"),
            ))
      ],
    );
  }
}

class _SearchContainer extends StatelessWidget {
  const _SearchContainer({Key? key}) : super(key: key);

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
            Go.to(const SearchDestinationPage());
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

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 35, horizontal: 15),
        child: GestureDetector(
          onTap: () => Go.back(),
          child:  CircleWithBoxShadow(
            child: Icon(Icons.arrow_back, size: 25.r),
          ),
        ),
      ),
    );
  }
}
