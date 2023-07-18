import 'package:flutter/material.dart';
import 'color_constant.dart';
import 'size_constant.dart';

class TextStyleConstant {
  static TextStyle textStyleBlack51Size14 = TextStyle(
      color: ColorConstant.colorBlack51, fontSize: SizeConstant.fontSize14);

  static TextStyle textStyleBlack51Size14Bold = TextStyle(
      color: ColorConstant.colorBlack51,
      fontSize: SizeConstant.fontSize14,
      fontWeight: FontWeight.bold);

  static TextStyle textStyleGray138Size14 = TextStyle(
      color: ColorConstant.colorGray138, fontSize: SizeConstant.fontSize14);
  static TextStyle textStyleGray138Size12 = TextStyle(
      color: ColorConstant.colorGray138, fontSize: SizeConstant.fontSize12);

  static TextStyle textStyleRed255Size14 = TextStyle(
      color: ColorConstant.colorRed255, fontSize: SizeConstant.fontSize14);
  static TextStyle textStyleRed253Size14 = TextStyle(
      color: ColorConstant.colorRed253, fontSize: SizeConstant.fontSize14);

  static TextStyle textStyleThemeColorSize12 =
      const TextStyle(color: ColorConstant.colorTheme, fontSize: 12);

  static TextStyle textStyleThemeColorSize14 = TextStyle(
      color: ColorConstant.colorTheme, fontSize: SizeConstant.fontSize14);

  static TextStyle textStyleWhiteSize14 =
      TextStyle(color: Colors.white, fontSize: SizeConstant.fontSize14);
}
