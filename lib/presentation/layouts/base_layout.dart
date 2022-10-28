import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/data/models/personal_info.dart';
import 'package:uber/presentation/pages/account/account_page.dart';
import 'package:uber/presentation/pages/activity/activity_page.dart';
import 'package:uber/presentation/pages/home/home_page.dart';

class BaseLayout extends StatefulWidget {
  final PersonalInfo personalInfo;
  const BaseLayout({required this.personalInfo, Key? key}) : super(key: key);

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  CupertinoTabController controller = CupertinoTabController();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Theme.of(context).primaryColor,
        height: 50.h,
        border: Border(
            top: BorderSide(color: ColorManager.lowOpacityGrey, width: 1.5.w)),
        inactiveColor: ColorManager.lightGrey,
        activeColor: ColorManager.black,
        items: [
          navigationBarItem(Icons.home_rounded, "Home"),
          navigationBarItem(Icons.archive_rounded, "Activity"),
          navigationBarItem(Icons.person, "Account"),
        ],
      ),
      controller: controller,
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return homePage();
          case 1:
            return activityPage();
          default:
            return accountPage();
        }
      },
    );
  }

  Widget homePage() => CupertinoTabView(
        builder: (context) => const CupertinoPageScaffold(child: HomePage()),
      );

  Widget activityPage() => CupertinoTabView(
        builder: (context) =>
            const CupertinoPageScaffold(child: ActivityPage()),
      );

  Widget accountPage() => CupertinoTabView(
        builder: (context) => const CupertinoPageScaffold(child: AccountPage()),
      );

  BottomNavigationBarItem navigationBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon, size: 25.r), label: label);
  }
}
