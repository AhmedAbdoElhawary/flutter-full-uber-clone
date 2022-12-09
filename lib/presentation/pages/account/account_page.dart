import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: REdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  const _SubTitleInfo(),
                  Padding(
                    padding: REdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: const [
                        Flexible(
                            child: _SquareContainer(
                          icon: Icons.square,
                          text: "Help",
                        )),
                        RSizedBox(width: 20),
                        Flexible(
                            child: _SquareContainer(
                          icon: Icons.square,
                          text: "Wallet",
                        )),
                        RSizedBox(width: 20),
                        Flexible(
                          child: _SquareContainer(
                            icon: Icons.square,
                            text: "Trips",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
                color: ColorManager.veryLowOpacityGrey2,
                height: 1,
                thickness: 10),
            Padding(
              padding: REdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  const _CustomListTitle(text: "Messages", icon: Icons.message),
                  const RSizedBox(height: 35),
                  const _CustomListTitle(text: "Settings", icon: Icons.message),
                  const RSizedBox(height: 35),
                  const _CustomListTitle(
                      text: "Earn by driving or delivering",
                      icon: Icons.message),
                  const RSizedBox(height: 35),
                  const _CustomListTitle(text: "Legal", icon: Icons.message),
                  const RSizedBox(height: 35),
                  Text(
                    "v0.1.2",
                    style: getLightStyle(
                        fontSize: 10, color: ColorManager.lowOpacityGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomListTitle extends StatelessWidget {
  const _CustomListTitle({Key? key, required this.icon, required this.text})
      : super(key: key);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const RSizedBox(width: 20),
        Text(text, style: getNormalStyle(fontSize: 22)),
      ],
    );
  }
}

class _SquareContainer extends StatelessWidget {
  const _SquareContainer({required this.icon, required this.text, Key? key})
      : super(key: key);
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.veryLowOpacityGrey2,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 30.r),
            const RSizedBox(height: 10),
            Text(text, style: getNormalStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}

class _SubTitleInfo extends StatelessWidget {
  const _SubTitleInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ignore: todo
            // TODO from firebase
            Text("ahmed abdo", style: getMediumStyle(fontSize: 35)),
            const RSizedBox(height: 8),
            const _StartCount(),
          ],
        ),
        const _PersonalImage(),
      ],
    );
  }
}

class _PersonalImage extends StatelessWidget {
  const _PersonalImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40.r,
      backgroundColor: ColorManager.veryLowOpacityGrey2,
      child: const Icon(Icons.person, color: ColorManager.grey, size: 60),
    );
  }
}

class _StartCount extends StatelessWidget {
  const _StartCount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.veryLowOpacityGrey2,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Icon(Icons.star, size: 17.r),
            const RSizedBox(width: 5),
            Text("5.0", style: getNormalStyle(fontSize: 17))
          ],
        ),
      ),
    );
  }
}
