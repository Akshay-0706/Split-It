import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitit/frontend/components/primary_btn.dart';
import 'package:splitit/frontend/components/secondary_btn.dart';

import '../../app_title.dart';
import '../../../global.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getHeight(40)),
          const AppTitle(),
          const Spacer(),
          PrimaryBtn(
              primaryColor: Theme.of(context).primaryColorDark,
              secondaryColor: Theme.of(context).primaryColorDark,
              titleColor: Theme.of(context).backgroundColor,
              padding: getWidth(20),
              hasIcon: true,
              iconData: FontAwesomeIcons.google,
              iconColor: Theme.of(context).backgroundColor,
              title: "Sign up with Google",
              tap: () {}),
          SizedBox(height: getHeight(20)),
          PrimaryBtn(
              primaryColor: Colors.blue,
              secondaryColor: Colors.blue[400]!,
              titleColor: Theme.of(context).primaryColorDark,
              padding: getWidth(20),
              hasIcon: true,
              iconData: FontAwesomeIcons.facebook,
              title: "Sign up with Facebook",
              tap: () {}),
          SizedBox(height: getHeight(60)),
          Text(
            "or",
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold,
                fontSize: getWidth(20)),
          ),
          SizedBox(height: getHeight(60)),
          SecondaryBtn(
            title: "Sign up with E-mail",
            color: Colors.grey[800]!,
            padding: getWidth(20),
            tap: () => Navigator.pushNamed(context, "/signup"),
          ),
          SizedBox(height: getHeight(20)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
            child: Text(
              "Welcome to Split-it, with this app you can easily keep track of your expenses, split bills among your friends and stay in your budget!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: getWidth(18),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
