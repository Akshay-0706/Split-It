import 'package:flutter/material.dart';
import 'package:splitit/routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeChanger themeChanger;

  @override
  void initState() {
    themeChanger = ThemeChanger();

    final window = WidgetsBinding.instance.window;

    if (window.platformBrightness == Brightness.light) {
      themeChanger.changeTheme();
    }

    window.onPlatformBrightnessChanged = () {
      setState(() {
        themeChanger.changeTheme();
      });
    };

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
