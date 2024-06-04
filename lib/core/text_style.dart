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
