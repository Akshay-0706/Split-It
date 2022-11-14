import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitit/size.dart';

import '../../../backend/user_account.dart';
import '../../../unimplemented/app_title.dart';
import '../../components/primary_btn.dart';

class WelcomeBody extends StatefulWidget {
  const WelcomeBody({super.key});

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
          const Spacer(),
          const AppTitle(),
          const Spacer(),
          LottieBuilder.asset(
            "assets/extras/lottie_welcome.json",
            repeat: false,
          ),
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
                UserAccount.googleLogin().then((value) {
                  User user = value!;
                  pref.setString("name", user.displayName!);
                  if (!pref.containsKey("email") ||
                      (pref.getString("email") != user.email)) {
                    pref.setStringList("transactions", []);
                    pref.setStringList("bills", []);
                    pref.setString("photo", user.photoURL!);
                    pref.setString("email", user.email!);
                    pref.setDouble("willGet", 0.0);
                    pref.setDouble("willPay", 0.0);
                    pref.setString("theme", "Auto");
                  }
                  Navigator.pushReplacementNamed(context, "/home");
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
