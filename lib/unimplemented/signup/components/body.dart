import 'package:flutter/material.dart';
import 'package:splitit/frontend/components/primary_btn.dart';

import '../../app_title.dart';
import '../../../frontend/components/secondary_btn.dart';
import '../../../global.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getHeight(40)),
            const AppTitle(),
            const Spacer(),
            Text(
              "E-mail address",
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getWidth(16)),
            ),
            SizedBox(height: getHeight(7)),
            customTextField(context, true),
            SizedBox(height: getHeight(20)),
            Text(
              "Password",
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getWidth(16)),
            ),
            SizedBox(height: getHeight(7)),
            customTextField(context, false),
            SizedBox(height: getHeight(10)),
            Text(
              "Use 8 or more characters with a mix of letters, numbers & symbols.",
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getWidth(16)),
            ),
            SizedBox(height: getHeight(40)),
            PrimaryBtn(
                primaryColor: Theme.of(context).primaryColor,
                secondaryColor: const Color.fromARGB(255, 255, 116, 97),
                padding: getWidth(0),
                title: "Get started, it's free!",
                tap: () {},
                titleColor: Theme.of(context).primaryColorDark,
                hasIcon: false),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Do you already have an account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getWidth(18)),
              ),
            ),
            SizedBox(height: getHeight(20)),
            SecondaryBtn(
              title: "Sign in",
              color: Colors.grey[800]!,
              padding: getWidth(0),
              tap: () => Navigator.pushNamed(context, "/signin"),
            ),
            SizedBox(height: getHeight(20)),
          ],
        ),
      ),
    );
  }

  Container customTextField(BuildContext context, bool forEmail) {
    return Container(
      height: getHeight(50),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).primaryColorLight.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(14)),
        child: TextField(
          onSubmitted: (value) {
          },
          obscureText: forEmail ? false : true,
          cursorRadius: const Radius.circular(7),
          keyboardType: forEmail
              ? TextInputType.emailAddress
              : TextInputType.visiblePassword,
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getWidth(18)),
          cursorColor: Theme.of(context).primaryColor,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
