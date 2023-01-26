import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/font_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: ColorManager.white,
      primaryColorLight: ColorManager.veryLightGrey,
      hintColor: ColorManager.lowOpacityGrey,
      shadowColor: ColorManager.veryLowOpacityGrey,
      focusColor: ColorManager.black,
      disabledColor: ColorManager.black54,
      dialogBackgroundColor: ColorManager.black87,
      hoverColor: ColorManager.black45,
      indicatorColor: ColorManager.black38,
      dividerColor: ColorManager.black12,
      scaffoldBackgroundColor: ColorManager.white,
      iconTheme: const IconThemeData(color: ColorManager.black),
      elevatedButtonTheme: elevatedButtonThemeData(),
      chipTheme:
          const ChipThemeData(backgroundColor: ColorManager.veryLowOpacityGrey),
      canvasColor: ColorManager.transparent,
      splashColor: ColorManager.white,
      appBarTheme: appBarTheme(),
      tabBarTheme: tabBarTheme(),
      textTheme: textTheme(),
      bottomAppBarTheme: const BottomAppBarTheme(color: ColorManager.black26),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(background: ColorManager.lightBlack)
          .copyWith(error: ColorManager.black),
    );
  }

  static ElevatedButtonThemeData elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (_) => ColorManager.black,
        ),
        minimumSize:
            MaterialStateProperty.all<Size>(const Size(double.infinity, 0)),
        padding: MaterialStateProperty.all<REdgeInsets>(REdgeInsets.all(13)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      ),
    );
  }

  static TabBarTheme tabBarTheme() {
    return TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: REdgeInsets.all(0),
      indicator: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ColorManager.black54, width: 1.5),
        ),
      ),
      labelColor: ColorManager.black,
      unselectedLabelColor: ColorManager.grey,
    );
  }

  static TextTheme textTheme() {
    return TextTheme(
      bodyLarge: getNormalStyle(color: ColorManager.black, fontSize: 25),
      bodyMedium: getNormalStyle(color: ColorManager.black, fontSize: 20),
      bodySmall: getMediumStyle(color: ColorManager.black, fontSize: 15),
      titleSmall: getNormalStyle(color: ColorManager.black, fontSize: 13),
      labelSmall: getMediumStyle(color: ColorManager.grey, fontSize: 13),
      displayLarge: getMediumStyle(color: ColorManager.grey, fontSize: 12),
      displayMedium: getMediumStyle(color: ColorManager.grey, fontSize: 11),
      displaySmall: getMediumStyle(color: ColorManager.grey, fontSize: 10),
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      elevation: 0,
      toolbarHeight: 50,
      color: ColorManager.white,
      shadowColor: ColorManager.lowOpacityGrey,
      iconTheme: const IconThemeData(color: ColorManager.black),
      titleTextStyle:
          getNormalStyle(fontSize: FontSize.s16, color: ColorManager.black),
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: getMediumStyle(fontSize: 17),
        padding: REdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        side: const BorderSide(width: 1, color: ColorManager.black45),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      primaryColor: ColorManager.black,
      primaryColorLight: ColorManager.black54,
      hintColor: ColorManager.darkGray,
      shadowColor: ColorManager.darkGray,
      focusColor: ColorManager.white,
      dialogBackgroundColor: ColorManager.white,
      hoverColor: ColorManager.grey,
      indicatorColor: ColorManager.grey,
      dividerColor: ColorManager.grey,
      iconTheme: const IconThemeData(color: ColorManager.white),
      chipTheme:
          const ChipThemeData(backgroundColor: ColorManager.lightDarkGray),
      disabledColor: ColorManager.white,
      scaffoldBackgroundColor: ColorManager.black,
      canvasColor: ColorManager.transparent,
      splashColor: ColorManager.darkGray,
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorManager.white),
        color: ColorManager.black,
        shadowColor: ColorManager.lowOpacityGrey,
        titleTextStyle:
            getNormalStyle(fontSize: FontSize.s16, color: ColorManager.white),
      ),
      textTheme: TextTheme(
        bodyLarge: getNormalStyle(color: ColorManager.white),
        bodyMedium: getNormalStyle(color: ColorManager.darkGray),
        bodySmall: getNormalStyle(color: ColorManager.veryLightGrey),
        displayLarge: getNormalStyle(color: ColorManager.grey, fontSize: 15),
        displayMedium: getBoldStyle(color: ColorManager.white, fontSize: 15),
        displaySmall: getMediumStyle(color: ColorManager.white, fontSize: 15),
        headlineSmall: getNormalStyle(color: Colors.grey[500]!),
        titleLarge: getNormalStyle(color: ColorManager.shimmerDarkGrey),
        titleSmall: getNormalStyle(color: ColorManager.darkGray),
        titleMedium: getNormalStyle(color: ColorManager.darkGray),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(color: ColorManager.grey),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(background: ColorManager.darkGray)
          .copyWith(error: ColorManager.grey),
    );
  }
}
