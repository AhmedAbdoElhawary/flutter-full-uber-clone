import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/presentation/pages/search_destination/widgets/search_text_field.dart';

class SearchDestinationPage extends StatelessWidget {
  SearchDestinationPage({super.key});
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130.h,
        elevation: 7,
        leading: const SizedBox(),
        actions: [
          Flexible(
            child: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding:
                        REdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, size: 30.r),
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
                          Icon(Icons.circle,
                              color: ColorManager.grey, size: 9.r),
                          Container(
                              height: 30.h,
                              width: 1.w,
                              color: ColorManager.black),
                          Icon(Icons.square, size: 9.r),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: REdgeInsetsDirectional.only(end: 15),
                        child: Column(
                          children: [
                            SearchTextField(
                                controller: fromController,
                                hint: "Where from?"),
                            const RSizedBox(height: 10),
                            SearchTextField(
                                controller: toController, hint: "Where to?"),
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
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: () {},
              child: const _CustomListTitle(
                  text: "Saved Places", icon: Icons.star)),
          const Divider(color: ColorManager.lightGrey, height: 1),
          GestureDetector(
            onTap: () {},
            child: const _CustomListTitle(
                text: "Set location on map", icon: Icons.location_on),
          ),
          const Divider(color: ColorManager.lightGrey, height: 1),
        ],
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
    required this.text,
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
