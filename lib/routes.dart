import 'package:flutter/material.dart';
import 'package:splitit/home/home.dart';
import 'package:splitit/register/register.dart';
import 'package:splitit/signin/signin.dart';
import 'package:splitit/signup/signup.dart';
import 'package:splitit/splash/splash.dart';
import 'package:splitit/welcome/welcome.dart';



Map<String, WidgetBuilder> routes = {
  "/": (context) => const Splash(),
  "/welcome": (context) => const Welcome(),
  // "/register": (context) => const Register(),
  // "/signup": (context) => const SignUp(),
  // "/signin": (context) => const SignIn(),
  "/home": (context) => const Home(),
};
