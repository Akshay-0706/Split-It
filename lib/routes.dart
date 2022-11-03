import 'package:flutter/material.dart';
import 'package:splitit/account/account.dart';
import 'package:splitit/home/home.dart';
import 'package:splitit/splash/splash.dart';
import 'package:splitit/transfer/transfer.dart';
import 'package:splitit/wallet/wallet.dart';
import 'package:splitit/welcome/welcome.dart';



Map<String, WidgetBuilder> routes = {
  "/": (context) => const Splash(),
  "/welcome": (context) => const Welcome(),
  // "/register": (context) => const Register(),
  // "/signup": (context) => const SignUp(),
  // "/signin": (context) => const SignIn(),
  "/home": (context) => const Home(),
  "/transfer":(context) => const Transfer(),
  "/wallet":(context) => const Wallet(),
  "/account":(context) => const Account(),
};
