import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitit/routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'global.dart';
import 'theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences pref = await SharedPreferences.getInstance();

  runApp(MyApp(pref: pref));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.pref});
  final SharedPreferences pref;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    final window = WidgetsBinding.instance.window;

    if (widget.pref.getString("theme") == "Light") {
      themeChanger.changeThemeMode("Light");
    }

    if (widget.pref.getString("theme") == "Dark") {
      themeChanger.changeThemeMode("Dark");
    }

    window.onPlatformBrightnessChanged = () {
      if (themeChanger.theme == "Auto") {
        setState(() {
          themeChanger.changeThemeMode("Auto");
        });
      }
    };

    themeChanger.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Split-It',
      theme: NewTheme.lightTheme(),
      darkTheme: NewTheme.darkTheme(),
      themeMode: themeChanger.currentTheme(),
      routes: routes,
    );
  }
}
