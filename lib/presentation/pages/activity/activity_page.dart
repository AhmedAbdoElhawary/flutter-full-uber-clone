import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/styles_manager.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(15.0),
          child: Container(
            constraints: BoxConstraints(maxHeight: 100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Activity", style: getMediumStyle(fontSize: 30)),
                Text("Past", style: getMediumStyle(fontSize: 17)),
                Text("You don't have any past activity",
                    style: getMediumStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
