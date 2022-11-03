import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitit/size.dart';

import '../../backend/auth.dart';
import 'splashContent.dart';

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
            Navigator.pushReplacementNamed(context, "/welcome");
          }
        },
        builder: (BuildContext context, double opacity, Widget? child) {
          // return SplashContent(opacity: opacity);

          return end == 0 && opacity == 0 && prefIsReady && signedIn
              ? FutureBuilder(
                  future: Auth.googleLogin().then((value) {
                    Navigator.pushNamed(context, "/home");
                  }),
                  builder: (context, snapshot) {
                    return Dialog(
                      elevation: 2,
                      child: Container(
                        height: getHeight(120),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      "Auto login...",
                                      textStyle: TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontSize: getHeight(18),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                      cursor: "",
                                    ),
                                    TypewriterAnimatedText(
                                      "Please wait few seconds...",
                                      textStyle: TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontSize: getHeight(18),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                      cursor: "",
                                    ),
                                    TypewriterAnimatedText(
                                      "Signing you in...",
                                      textStyle: TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontSize: getHeight(18),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                      cursor: "",
                                    ),
                                    TypewriterAnimatedText(
                                      "Check your internet...",
                                      textStyle: TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontSize: getHeight(18),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                      cursor: "",
                                    ),
                                  ],
                                )
                              ],
                            ),
                            CircularProgressIndicator(
                              color: Theme.of(context).backgroundColor,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : SplashContent(opacity: opacity);
        },
      ),
    );
  }
}
