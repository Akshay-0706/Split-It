import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_title.dart';
import '../../../frontend/components/primaryBtn.dart';
import '../../../frontend/components/secondary_btn.dart';
import '../../../size.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  bool remember = false;

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
              "Login",
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
            Row(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          remember = remember ? false : true;
                        });
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: Ink(
                        width: getWidth(24),
                        height: getHeight(24),
                        decoration: const BoxDecoration(),
                        child: remember
                            ? FaIcon(
                                Icons.check_box_rounded,
                                size: getWidth(24),
                                color: Theme.of(context).primaryColor,
                              )
                            : FaIcon(
                                Icons.check_box_outline_blank_rounded,
                                size: getWidth(24),
                                color: Theme.of(context).primaryColorLight,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: getWidth(10),
                    ),
                    Text(
                      "Remember me",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: getWidth(16)),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "Forgot password",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontSize: getWidth(16)),
                ),
              ],
            ),
            SizedBox(height: getHeight(20)),
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
                "Don't have an account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getWidth(18)),
              ),
            ),
            SizedBox(height: getHeight(20)),
            SecondaryBtn(
              title: "Sign up",
              color: Colors.grey[800]!,
              padding: getWidth(0),
              tap: () => Navigator.pushNamed(context, "/signup"),
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
          onSubmitted: (value) {},
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
