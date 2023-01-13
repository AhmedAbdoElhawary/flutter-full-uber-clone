import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';
import 'package:uber/presentation/common/widgets/custom_google_map.dart';
import 'package:uber/presentation/pages/map/view/initial_map/initial_map_page.dart';

const double _the20padding = 20;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: _the20padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorManager.lightPurple,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      const WhereToSearchBar(),
                      const ChooseSavedPlace(),
                    ],
                  ),
                ),
                const _CustomDivider(),
                const SetDestinationOnMap(),
                const _CustomDivider(),
                const _AroundYou(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContainerForEnableTapOnMap extends StatelessWidget {
  const _ContainerForEnableTapOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.transparent,
        borderRadius: BorderRadius.circular(15.r),
      ),
    );
  }
}

class WhereToSearchBar extends StatelessWidget {
  const WhereToSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 20.0),
      child: GestureDetector(
        onTap: () {
          Go.to(const MapScreen(isThatSearchDestination: true));
        },
        child: Container(
          padding: REdgeInsets.symmetric(vertical: 12, horizontal: 15),
          decoration: BoxDecoration(
            color: ColorManager.veryLightGrey,
            borderRadius: BorderRadius.circular(45.r),
          ),
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.search_rounded, size: 35.r),
              const RSizedBox(width: 10),
              Text(
                "Where to?",
                style:
                    getMediumStyle(color: ColorManager.black54, fontSize: 22),
              ),
              const Spacer(flex: 5),
              Container(
                  color: ColorManager.lightGrey, height: 40.h, width: 0.5.w),
              const Spacer(flex: 1),
              Container(
                  padding: REdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.watch_later_rounded),
                      const RSizedBox(width: 5),
                      Text("Now", style: getMediumStyle()),
                      const RSizedBox(width: 5),
                      const Icon(Icons.keyboard_arrow_down),
                      const RSizedBox(width: 10),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseSavedPlace extends StatelessWidget {
  const ChooseSavedPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child:
            const _CustomButton(icon: Icons.star, text: "Choose a saved place"),
        onPressed: () {});
  }
}

class SetDestinationOnMap extends StatelessWidget {
  const SetDestinationOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: _the20padding),
      child: TextButton(
          child: const _CustomButton(
              icon: Icons.location_on, text: "Set destination on map"),
          onPressed: () {}),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  const _CustomButton({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: REdgeInsets.all(0),
        leading: Container(
            padding: REdgeInsets.all(7),
            decoration: const BoxDecoration(
                color: ColorManager.veryLightGrey, shape: BoxShape.circle),
            child: Icon(icon, color: ColorManager.black)),
        title: Text(text, style: getMediumStyle(fontSize: 20)),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded));
  }
}

class _AroundYou extends StatelessWidget {
  const _AroundYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: _the20padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.symmetric(vertical: 25.0),
            child: Text("Around you",
                style: getMediumStyle(fontSize: _the20padding)),
          ),
          const SmallMapDisplay(),
        ],
      ),
    );
  }
}

class SmallMapDisplay extends StatelessWidget {
  const SmallMapDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Go.to(const MapScreen());
      },
      child: Container(
        height: 200.h,
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: const CustomGoogleMap()),
            const _ContainerForEnableTapOnMap(),
          ],
        ),
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(color: ColorManager.lightGrey, indent: 65, height: 1.h);
  }
}
