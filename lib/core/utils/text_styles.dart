import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:flutter/widgets.dart';

class TextStyles {
  static TextStyle getHeadLine1({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 20,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? AppColors.primaryColor,
    );
  }

  static TextStyle getHeadLine2({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 18,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.primaryColor,
    );
  }

  static TextStyle getTitle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.primaryColor,
    );
  }

  static TextStyle getBody({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.darkGreyColor,
    );
  }

  static TextStyle getSmall({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.primaryColor,
    );
  }
}
