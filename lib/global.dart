library config.globals;

import 'package:flutter/material.dart';

import 'size.dart';
import 'theme.dart';

ThemeChanger themeChanger = ThemeChanger();

getWidth(double width) => (width / 375.0) * SizeConfig.width;
getHeight(double height) => (height / 812.0) * SizeConfig.height;

snackBarBuilder(BuildContext context, String message, Color fg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(
          horizontal: getHeight(30), vertical: getHeight(10)),
      backgroundColor: Theme.of(context).backgroundColor,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fg,
          fontSize: getHeight(14),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
