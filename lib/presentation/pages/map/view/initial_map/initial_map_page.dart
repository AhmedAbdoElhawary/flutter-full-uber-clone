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
  const MapScreen({this.isThatSearchDestination = false, Key? key})
      : super(key: key);
  final bool isThatSearchDestination;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapLogic>(
      id: 'update',
      tag: '2',
      initState: (state) {
        Get.put<MapLogic>(MapLogic(), tag: '2');
      },
      builder: (mapControl) {
        switch (isThatSearchDestination) {
          case true:
            return buildScaffold(mapControl, false);
          default:
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark),
              child: buildScaffold(mapControl, true),
            );
        }
      },
    );
  }

  Scaffold buildScaffold(MapLogic mapControl, bool initialMap) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
              () => Stack(
            fit: StackFit.expand,
            children: [
              mapControl.getCurrentPosition != null
                  ? buildScreen(mapControl,initialMap)
                  : const Center(
                  child: ThineCircularProgress(color: ColorManager.black)),
              if (initialMap) const _BackButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildScreen(MapLogic mapControl,bool initialMap) {
    if(initialMap){
      return Column(
        children: [
          Flexible(child: MapDisplay(mapControl: mapControl)),
          _SearchContainer(mapControl),
        ],
      );
    }else{
      return MapDisplay(mapControl: mapControl,initialMap: false);
    }

  }
}

class MapDisplay extends StatelessWidget {
  const MapDisplay({Key? key, required this.mapControl,this.initialMap=true}) : super(key: key);

  final MapLogic mapControl;
  final bool initialMap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const CustomGoogleMap(tag: '2', id: "update"),
        if(initialMap)...[
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: REdgeInsets.symmetric(vertical: 35, horizontal: 15),
                child: const MyLocationIcon(tag: "2"),
              ))
        ]else...[
          const DoneButtonWithLocationIcon(),
          const Align(alignment: Alignment.topCenter, child: ResultsOfSearchText()),
        ],

      ],
    );
  }
}

class _SearchContainer extends StatelessWidget {
  const _SearchContainer(this.mapControl, {Key? key}) : super(key: key);
  final MapLogic mapControl;
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
            Go.offAll(const MapScreen(isThatSearchDestination: true));
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
          child: CircleWithBoxShadow(child: Icon(Icons.arrow_back, size: 25.r)),
        ),
      ),
    );
  }
}
