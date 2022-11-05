import 'package:flutter/material.dart';
import 'package:splitit/frontend/home/home.dart';
import 'package:splitit/frontend/splash/splash.dart';
import 'package:splitit/frontend/welcome/welcome.dart';

import 'frontend/newbill/bill.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const Splash(),
  "/welcome": (context) => const Welcome(),
  // "/register": (context) => const Register(),
  // "/signup": (context) => const SignUp(),
  // "/signin": (context) => const SignIn(),
  "/home": (context) => const Home(),
  "/bill": (context) => const Bill(),
};
