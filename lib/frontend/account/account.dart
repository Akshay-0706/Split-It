import 'package:flutter/material.dart';
import 'package:splitit/frontend/account/components/body.dart';

class Account extends StatelessWidget {
  const Account(
      {super.key,
      required this.name,
      required this.email,
      required this.photo,
      required this.theme,
      required this.changeTheme,
      required this.changeTab});
  final String name, email, photo, theme;
  final Function changeTheme, changeTab;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => changeTab(0),
      child: Scaffold(
        body: AccountBody(
          name: name,
          email: email,
          photo: photo,
          theme: theme,
          changeTheme: changeTheme,
          changeTab: changeTab,
        ),
      ),
    );
  }
}
