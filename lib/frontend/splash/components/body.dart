import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitit/frontend/splash/components/signin_dialog.dart';

import 'splash_content.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  double begin = 0, end = 1;
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  late SharedPreferences pref;
  bool prefIsReady = false;
  late bool signedIn;

  @override
  void initState() {
    sharedPreferences.then((value) {
      pref = value;
      setState(() {
        signedIn = pref.containsKey("email");
        prefIsReady = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: begin, end: end),
        duration: const Duration(milliseconds: 1000),
        onEnd: () {
          if (end != 0) {
            Future.delayed(const Duration(milliseconds: 1000), () {
              setState(() {
                begin = 1;
                end = 0;
              });
            });
          }
          if (end == 0 && prefIsReady & !signedIn) {
            Navigator.pushNamed(context, "/welcome");
          }
        },
        builder: (BuildContext context, double opacity, Widget? child) {
          // return SplashContent(opacity: opacity);

          return end == 0 && opacity == 0 && prefIsReady && signedIn
              ? const SigninDialog()
              : SplashContent(opacity: opacity);
        },
      ),
    );
  }
}
