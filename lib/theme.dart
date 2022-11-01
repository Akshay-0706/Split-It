import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  static bool isThemeDark = true;

  bool isDarkMode() => isThemeDark;

  ThemeMode currentTheme() {
    return isThemeDark ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    isThemeDark = !isThemeDark;
    notifyListeners();
  }
}

class NewTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: "OverPass",
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Global.background,
        iconTheme: IconThemeData(color: Global.foreground),
      ),
      drawerTheme: DrawerThemeData(backgroundColor: Global.drawerBg),
      // textTheme: lightTextTheme(),
      scaffoldBackgroundColor: Global.background,
      backgroundColor: Global.background,
      colorScheme:
          const ColorScheme.light().copyWith(secondary: Global.primary),
      primaryColor: Global.primary,
      primaryColorLight: Global.foregroundAlt,
      primaryColorDark: Global.foreground,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: "OverPass",
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Global.backgroundDark,
        iconTheme: IconThemeData(color: Global.foregroundDark),
      ),
      drawerTheme: DrawerThemeData(backgroundColor: Global.drawerBgDark),
      // textTheme: darkTextTheme(),
      scaffoldBackgroundColor: Global.backgroundDark,
      backgroundColor: Global.backgroundDark,
      colorScheme:
          const ColorScheme.dark().copyWith(secondary: Global.primaryDark),
      primaryColor: Global.primaryDark,
      primaryColorLight: Global.foregroundAltDark,
      primaryColorDark: Global.foregroundDark,
    );
  }

  // static TextTheme lightTextTheme() {
  //   return TextTheme(
  //     headline1: TextStyle(color: Global.primary),
  //     // headline2: TextStyle(color: Global.primaryAlt),
  //     bodyText1: TextStyle(color: Global.foreground),
  //     bodyText2: TextStyle(color: Global.foregroundAlt),
  //   );
  // }

  // static TextTheme darkTextTheme() => TextTheme(
  //       headline1: TextStyle(color: Global.primaryDark),
  //       // headline2: TextStyle(color: Global.primaryAltDark),
  //       bodyText1: TextStyle(color: Global.foregroundDark),
  //       bodyText2: TextStyle(color: Global.foregroundAltDark),
  //     );
}

class Global {
  // Light mode colors
  static Color primary = const Color(0xff5E00F5);
  static Color foreground = const Color(0xff1C1C23);
  static Color foregroundAlt = Colors.black;
  static Color background = const Color(0xffFCF7F8);
  static Color drawerBg = const Color(0xffD2D2D2);

  // Dark mode colors
  static Color? primaryDark = const Color(0xff5E00F5);
  static Color foregroundDark = const Color(0xffFCF7F8);
  static Color foregroundAltDark = const Color(0xffD2D2D2);
  static Color backgroundDark = const Color(0xff1C1C23);
  static Color drawerBgDark = Colors.black;
}
