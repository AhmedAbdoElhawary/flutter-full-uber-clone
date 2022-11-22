import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uber/core/resources/assets_manager.dart';
import 'package:uber/presentation/pages/map/logic/map_logic.dart';
import 'package:uber/presentation/pages/map/widgets/map_widgets/circle_with_box_shadow.dart';

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

          return ScaleTransition(
            scale: _animation,
            child: GestureDetector(
              onTap: () async {
                await mapController.goToMyCurrentLocation();

                await animateLocationIcon(false);
                mapController.changeShowingIcon(false);
              },
              child: CircleWithBoxShadow(
                child: SvgPicture.asset(IconsAssets.myLocation, height: 25),
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
