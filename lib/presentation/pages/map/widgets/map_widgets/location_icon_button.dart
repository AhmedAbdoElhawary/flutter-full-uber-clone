import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/presentation/pages/map/widgets/map_widgets/location_icon.dart';

class LocationIconButton extends StatelessWidget {
  const LocationIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 35, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Align(
                alignment: Alignment.centerRight,
                child: MyLocationIcon(tag: "2"))
          ],
        ),
      ),
    );
  }
}
