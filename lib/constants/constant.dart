import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_constant.dart';

class Constant {
  static const appUiOverlayStyle = SystemUiOverlayStyle(
    //设置状态栏透明
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: ColorConstant.colorTransparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  static OutlineInputBorder editBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstant.colorWhite216),
      borderRadius: BorderRadius.all(Radius.circular(6.0)));
  static OutlineInputBorder focusedBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstant.colorTheme),
      borderRadius: BorderRadius.all(Radius.circular(6.0)));

  static Map<int, String> weekMap = {
    1: "一",
    2: "二",
    3: "三",
    4: "四",
    5: "五",
    6: "六",
    7: "日"
  };
}
