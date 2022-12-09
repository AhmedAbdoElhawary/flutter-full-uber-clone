import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';
import 'package:uber/presentation/common/widgets/custom_circulars_progress.dart';
import 'package:uber/presentation/common/widgets/custom_elevated_button.dart';
import 'package:uber/presentation/common/widgets/custom_google_map.dart';
import 'package:uber/presentation/pages/map/logic/map_logic.dart';
import 'package:uber/presentation/pages/map/logic/search_destination/search_destination_logic.dart';
import 'package:uber/presentation/pages/map/widgets/map_widgets/location_icon.dart';
import 'package:uber/presentation/pages/map/widgets/search_text_field.dart';

class SearchDestinationPage extends StatelessWidget {
  const SearchDestinationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// ------------------------------------------here----->
    MapLogic mapControl = Get.put(MapLogic(), tag: "3");
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => mapControl.getCurrentPosition != null
              ? MapDisplay(mapControl: mapControl)
              : const Center(
                  child: ThineCircularProgress(color: ColorManager.black)),
        ),
      ),
    );
  }
}

class MapDisplay extends StatelessWidget {
  const MapDisplay({Key? key, required this.mapControl}) : super(key: key);

  final MapLogic mapControl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomGoogleMap(mapControl: mapControl),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: REdgeInsets.symmetric(vertical: 35, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Align(
                    alignment: Alignment.centerRight, child: MyLocationIcon(tag: "3")),
                const RSizedBox(height: 20),
                CustomElevatedButton(
                  onPressed: () {},
                  backgroundColor: ColorManager.black,
                  withoutPadding: true,
                  circularRadius: 0,
                  child: Text(
                    "Done",
                    style:
                        getNormalStyle(color: ColorManager.white, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
        const Align(alignment: Alignment.topCenter, child: SearchDestination()),
      ],
    );
  }
}

class SearchDestination extends StatefulWidget {
  const SearchDestination({super.key});

  @override
  State<SearchDestination> createState() => _SearchDestinationState();
}

class _SearchDestinationState extends State<SearchDestination> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchDestinationLogic>(
      id: "pointer",
      initState: (state) {
        Get.put(SearchDestinationLogic(), tag: "1");
      },
      tag: "1",
      builder: (controller) {
        return Stack(
          children: [
            if (!controller.getDisAppear)
              Positioned.fill(
                top: controller.getPositionInTop,
                child: Listener(
                  onPointerUp: (d)=>controller.onListPointerUp(d, context),
                  onPointerMove: controller.onListPointerMove,
                  child: Container(
                    color: ColorManager.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {},
                              child: const _CustomListTitle(
                                  text: "Saved Places", icon: Icons.star)),
                          const Divider(
                              color: ColorManager.lightGrey, height: 1),
                          GestureDetector(
                            onTap: () {},
                            child: const _CustomListTitle(
                                text: "Set location on map",
                                icon: Icons.location_on),
                          ),
                          const Divider(
                              color: ColorManager.lightGrey, height: 1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            Align(alignment: Alignment.topCenter, child: SearchBars()),
          ],
        );
      },
    );
  }
}

class SearchBars extends StatelessWidget {
  SearchBars({Key? key}) : super(key: key);

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final SearchDestinationLogic controller = Get.find(tag: "1");
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      shadowColor: ColorManager.grey.withOpacity(0.3),
      color: ColorManager.white,
      child: SizedBox(
        height: 130.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Padding(
                padding: REdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Go.back();
                        },
                        child: Icon(Icons.arrow_back, size: 30.r)),
                    const Spacer(),
                    const Text("Switch rider"),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Icon(Icons.circle, color: ColorManager.grey, size: 9.r),
                      Container(
                          height: 30.h, width: 1.w, color: ColorManager.black),
                      Icon(Icons.square, size: 9.r),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: REdgeInsetsDirectional.only(end: 15),
                    child: Column(
                      children: [
                        Listener(
                          onPointerDown: (d) {
                            controller.changeTheAppearing(false);
                          },
                          child: SearchTextField(
                              controller: fromController, hint: "Where from?"),
                        ),
                        const RSizedBox(height: 10),
                        Listener(
                          onPointerDown: (d) {
                            controller.changeTheAppearing(false);
                          },
                          child: SearchTextField(
                              controller: toController, hint: "Where to?"),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: REdgeInsetsDirectional.only(end: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        RSizedBox(height: 40),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomListTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  const _CustomListTitle({
    Key? key,
    required this.icon,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorManager.lightGrey,
            radius: 22.r,
            child: Center(
                child: Icon(icon, color: ColorManager.white, size: 25.r)),
          ),
          const RSizedBox(width: 20),
          Text(text),
        ],
      ),
    );
  }
}
