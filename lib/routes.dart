import 'package:flutter/material.dart';
import 'package:splitit/frontend/home/home.dart';
import 'package:splitit/frontend/splash/splash.dart';
import 'package:splitit/frontend/welcome/welcome.dart';

import 'frontend/bill/bill.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const Splash(),
  "/welcome": (context) => const Welcome(),
  "/home": (context) => const Home(),
};
