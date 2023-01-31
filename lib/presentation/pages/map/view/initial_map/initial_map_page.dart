import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';
import 'package:uber/presentation/common/widgets/custom_circulars_progress.dart';
import 'package:uber/presentation/common/widgets/custom_google_map.dart';
import 'package:uber/presentation/pages/home/home_page.dart';
import 'package:uber/presentation/pages/map/logic/map_logic.dart';
import 'package:uber/presentation/pages/map/logic/search_destination/appearance_of_search_list_logic.dart';
import 'package:uber/presentation/pages/map/widgets/map_widgets/results_of_search_text.dart';
import 'package:uber/presentation/pages/map/widgets/map_widgets/circle_with_box_shadow.dart';
import 'package:uber/presentation/pages/map/widgets/map_widgets/location_icon.dart';
import 'package:uber/presentation/pages/map/widgets/map_widgets/location_icon_button.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({this.isThatSearchDestination = false, Key? key})
      : super(key: key);
  final bool isThatSearchDestination;
  @override
  Widget build(BuildContext context) {
    final AppearanceOfSearchListLogic appearanceController =
        Get.put(AppearanceOfSearchListLogic(), tag: "1");
    return GetBuilder<MapLogic>(
      id: 'update',
      tag: '2',
      initState: (state) {
        Get.put<MapLogic>(MapLogic(), tag: '2');
      },
      builder: (mapControl) {
        switch (isThatSearchDestination) {
          case true:
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                  statusBarColor: appearanceController.getDisplayRidersMenu
                      ? appearanceController.colorOfAppBar.value
                      : Colors.white,
                  statusBarIconBrightness: Brightness.dark),
              child: _BuildMapScreen(mapControl, false),
            );
          default:
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark),
              child: _BuildMapScreen(mapControl, true),
            );
        }
      },
    );
  }
}

class _BuildMapScreen extends StatelessWidget {
  const _BuildMapScreen(this.mapControl, this.initialMap, {Key? key})
      : super(key: key);
  final MapLogic mapControl;
  final bool initialMap;
  @override
  Widget build(BuildContext context) {
    final AppearanceOfSearchListLogic appearanceController = Get.find(tag: "1");
    return Scaffold(
      body: Obx(
        () => Stack(
          fit: StackFit.expand,
          children: [
            mapControl.getCurrentPosition != null
                ? buildScreen(mapControl, initialMap)
                : const Center(
                    child: ThineCircularProgress(color: ColorManager.black)),
            if (initialMap) const _BackButton(),
            if (appearanceController.getDisplayRidersMenu)
              const _TheDynamicRidersAppBar()
          ],
        ),
      ),
    );
  }

  Widget buildScreen(MapLogic mapControl, bool initialMap) {
    switch (initialMap) {
      case true:
        return Column(
          children: [
            Flexible(child: MapDisplay(mapControl: mapControl)),
            _SearchContainer(mapControl),
          ],
        );
      default:
        return MapDisplay(mapControl: mapControl, initialMap: false);
    }
  }
}

const List cars = [
  {'id': 0, 'name': 'Select a Ride', 'price': "EGP 230.0"},
  {'id': 1, 'name': 'UberGo', 'price': "EGP 230.0"},
  {'id': 2, 'name': 'Go Sedan', 'price': "EGP 300.0"},
  {'id': 3, 'name': 'UberXL', 'price': "EGP 250.0"},
  {'id': 4, 'name': 'UberAuto', 'price': "EGP 130.0"},
];

class MapDisplay extends StatelessWidget {
  const MapDisplay({Key? key, required this.mapControl, this.initialMap = true})
      : super(key: key);

  final MapLogic mapControl;
  final bool initialMap;
  @override
  Widget build(BuildContext context) {
    final AppearanceOfSearchListLogic appearanceController = Get.find(tag: "1");
    return Stack(
      // mainAxisSize: MainAxisSize.min,
      children: [
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            height: appearanceController.getDisplayRidersMenu
                ? constraints.maxHeight / 1.85
                : null,
            child: _BuildMapDisplay(initialMap: initialMap),
          );
        }),
        if (appearanceController.getDisplayRidersMenu) const _RidersMenu(),
      ],
    );
  }
}

class _TheDynamicRidersAppBar extends StatelessWidget {
  const _TheDynamicRidersAppBar();

  @override
  Widget build(BuildContext context) {
    final AppearanceOfSearchListLogic appearanceController = Get.find(tag: "1");
    return Obx(() {
      double opacity = appearanceController.getOpacityOfAppBar;
      return Align(
        alignment: Alignment.topCenter,
        child: AnimatedOpacity(
          duration: const Duration(microseconds: 300),
          opacity: opacity,
          child: Container(
            color: ColorManager.black,
            height: 70.h,
            width: double.infinity,
            child: Padding(
              padding: REdgeInsets.symmetric(vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (opacity == 1) ...[
                    const RSizedBox(width: 10),
                    GestureDetector(
                      onTap:appearanceController.stepDownRidersMenu,
                      child: const Icon(Icons.arrow_downward_rounded,
                          color: ColorManager.shimmerDarkGrey),
                    ),
                    const Spacer(flex: 4),
                    Text("Choose a ride",
                        style: getLightStyle(
                            fontSize: 18, color: ColorManager.white)),
                    const Spacer(flex: 5),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _BuildMapDisplay extends StatelessWidget {
  const _BuildMapDisplay({required this.initialMap});

  final bool initialMap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const CustomGoogleMap(tag: '2', id: "update"),
        if (initialMap) ...[
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: REdgeInsets.symmetric(vertical: 35, horizontal: 15),
                child: const MyLocationIcon(tag: "2"),
              ))
        ] else ...[
          const LocationIconButton(),
          const Align(
              alignment: Alignment.topCenter, child: ResultsOfSearchText()),
        ],
      ],
    );
  }
}

class _RidersMenu extends StatelessWidget {
  const _RidersMenu();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppearanceOfSearchListLogic>(
      id: "pointer",
      initState: (state) {
        Get.find<AppearanceOfSearchListLogic>(tag: "1");
      },
      tag: "1",
      builder: (controller) {
        int selectedCarId = 1;

        return DraggableScrollableSheet(
            initialChildSize: 0.465,
            minChildSize: 0.465,
            maxChildSize: 1,
            controller: controller.draggableScrollableController.value,
            snapSizes: const [0.465, 1],
            snap: true,
            builder: (BuildContext context, scrollSheetController) {
              return Container(
                  color: Colors.white,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const ClampingScrollPhysics(),
                    controller: scrollSheetController,
                    itemCount: cars.length,
                    itemBuilder: (BuildContext context, int index) {
                      final car = cars[index];
                      if (index == 0) {
                        return const _HeadWidgetsOfRidersMenu();
                      }
                      return Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        child: ListTile(
                          contentPadding: REdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          onTap: () {
                            // setState(() {
                            //   selectedCarId = car['id'];
                            // });
                          },
                          leading:
                              const Icon(Icons.car_crash_rounded, size: 60),
                          title: Text(car['name'],
                              style: getNormalStyle(fontSize: 20)),
                          subtitle: Text(
                            "12:06am . 4 min away",
                            style: getNormalStyle(
                                fontSize: 13, color: ColorManager.grey),
                          ),
                          trailing: Text(
                            car['price'].toString(),
                            style: getNormalStyle(fontSize: 15),
                          ),
                          selected: selectedCarId == car['id'],
                          selectedTileColor: Colors.grey[200],
                        ),
                      );
                    },
                  ));
            });
      },
    );
  }
}

class _HeadWidgetsOfRidersMenu extends StatelessWidget {
  const _HeadWidgetsOfRidersMenu();

  @override
  Widget build(BuildContext context) {
    MapLogic mapLogic = Get.find(tag: '2');

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const _DashIcon(),
                Obx(
                  () => Text(
                    mapLogic.pointsDirection.value?.totalDuration ?? "4 MIN",
                    style: getMediumStyle(fontSize: 14),
                  ),
                ),
                const RSizedBox(height: 5),
                Text(
                  'Choose a ride, or swipe up for more',
                  style: getNormalStyle(fontSize: 14),
                ),
              ],
            )),
        const Divider(color: ColorManager.grey, height: 1),
      ],
    );
  }
}

class _DashIcon extends StatelessWidget {
  const _DashIcon();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 3, bottom: 12),
      child: Container(
          width: 50.w,
          height: 4.h,
          decoration: BoxDecoration(
              color: ColorManager.lightGrey,
              borderRadius: BorderRadius.circular(5))),
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
          onTap: () => Go.offAll(const HomePage()),
          child: CircleWithBoxShadow(child: Icon(Icons.arrow_back, size: 25.r)),
        ),
      ),
    );
  }
}
