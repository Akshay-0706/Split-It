import 'package:flutter/material.dart';
import 'package:splitit/frontend/splash/components/signin_texts.dart';

import '../../../backend/user_account.dart';
import '../../../size.dart';

class SigninDialog extends StatelessWidget {
  const SigninDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserAccount.googleLogin().then((value) {
        Navigator.pushReplacementNamed(context, "/home");
      }),
      builder: (context, snapshot) {
        return Dialog(
          elevation: 2,
          child: Container(
            height: getHeight(120),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [SigninTexts()],
                ),
                CircularProgressIndicator(
                  color: Theme.of(context).backgroundColor,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
