import 'package:flutter/material.dart';

TextTheme _getTextTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

TextStyle titleMedium(BuildContext context,
    {double? size, FontWeight? fontWeight}) {
  return _getTextTheme(context).titleMedium!.copyWith(
      fontSize: size ?? _getTextTheme(context).titleMedium!.fontSize,
      fontWeight: fontWeight ?? _getTextTheme(context).titleMedium!.fontWeight);
}

TextStyle titleSmall(BuildContext context,
    {double? size, FontWeight? fontWeight}) {
  return _getTextTheme(context).titleMedium!.copyWith(
      fontSize: size ?? _getTextTheme(context).titleSmall!.fontSize,
      fontWeight: fontWeight ?? _getTextTheme(context).titleSmall!.fontWeight);
}

TextStyle titleLarge(BuildContext context,
    {double? size, FontWeight? fontWeight}) {
  return _getTextTheme(context).titleLarge!.copyWith(
      fontSize: size ?? _getTextTheme(context).titleLarge!.fontSize,
      fontWeight: fontWeight ?? _getTextTheme(context).titleLarge!.fontWeight);
}

TextStyle bodySmall(BuildContext context,
    {double? size, FontWeight? fontWeight}) {
  return _getTextTheme(context).bodyMedium!.copyWith(
      fontSize: size ?? _getTextTheme(context).bodySmall!.fontSize,
      fontWeight: fontWeight ?? _getTextTheme(context).bodySmall!.fontWeight);
}

TextStyle bodyMedium(BuildContext context,
    {double? size, FontWeight? fontWeight}) {
  return _getTextTheme(context).bodyMedium!.copyWith(
      fontSize: size ?? _getTextTheme(context).bodySmall!.fontSize,
      fontWeight: fontWeight ?? _getTextTheme(context).bodyMedium!.fontWeight);
}

TextStyle bodyLarge(BuildContext context,
    {double? size, FontWeight? fontWeight}) {
  return _getTextTheme(context).titleMedium!.copyWith(
      fontSize: size ?? _getTextTheme(context).bodyLarge!.fontSize,
      fontWeight: fontWeight ?? _getTextTheme(context).bodyLarge!.fontWeight);
}
