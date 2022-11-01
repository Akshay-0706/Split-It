import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitit/size.dart';

import '../../backend/auth/auth.dart';
import '../../components/appTitle.dart';
import '../../components/primarybtn.dart';

class WelcomeBody extends StatefulWidget {
  WelcomeBody({super.key});

  @override
  State<WelcomeBody> createState() => _WelcomeBodyState();
}

class _WelcomeBodyState extends State<WelcomeBody> {
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  late SharedPreferences pref;
  bool prefIsReady = false, signin = false;

  @override
  void initState() {
    sharedPreferences.then((value) {
      pref = value;
      setState(() {
        prefIsReady = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getHeight(100)),
          const AppTitle(),
          SizedBox(height: getHeight(40)),
          // if (ThemeChanger.isThemeDark)

          LottieBuilder.asset(
            "assets/extras/lottie_welcome.json",
            repeat: false,
          ),
          // if (!ThemeChanger.isThemeDark)
          //   LottieBuilder.asset(
          //     "assets/extras/lottie_light.json",
          //     width: getHeight(300),
          //     repeat: false,
          //   ),

          // Stack(
          //   children: [
          //     Image.asset("assets/extras/welcome_1.png"),
          //     Row(
          //       children: [
          //         const Spacer(),
          //         Image.asset("assets/extras/welcome_3.png"),
          //       ],
          //     ),
          //     Image.asset("assets/extras/welcome.png"),
          //     Padding(
          //       padding: EdgeInsets.only(top: getHeight(300)),
          //       child: Row(
          //         children: [
          //           const Spacer(),
          //           Image.asset(
          //             "assets/extras/welcome_2.png",
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
            child: Text(
              "Welcome to Split-it, with this app you can easily keep track of your expenses, split bills among your friends and stay in your budget!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getWidth(16),
              ),
            ),
          ),
          SizedBox(height: getHeight(20)),
          if (prefIsReady && !signin)
            PrimaryBtn(
              title: "Continue",
              primaryColor: Theme.of(context).primaryColor,
              secondaryColor: Theme.of(context).primaryColor.withOpacity(0.8),
              titleColor: Colors.white,
              padding: getWidth(20),
              hasIcon: false,
              tap: () {
                setState(() {
                  signin = true;
                });
                Auth.googleLogin().then((value) {
                  User user = value!;
                  pref.setString("name", user.displayName!);
                  pref.setString("photo", user.photoURL!);
                  pref.setString("email", user.email!);
                  Navigator.pushNamed(context, "/home");
                });
              },
            ),
          if (!prefIsReady || signin)
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          SizedBox(height: getHeight(60)),
        ],
      ),
    );
  }
}
