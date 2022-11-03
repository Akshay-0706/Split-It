import 'package:flutter/material.dart';

import '../../size.dart';
import 'navItem.dart';
import 'navSelected.dart';

class NavBar extends StatefulWidget {
  NavBar({
    Key? key,
    required this.changeTab,
  }) : super(key: key);
  final Function changeTab;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int current = 0;

  List<String> iconNames = ["home", "transfer", "wallet", "account"];

  List<String> tabNames = ["Home", "Transfer", "Wallet", "Account"];

  changeNav(index) {
    setState(() {
      current = index;
    });
    widget.changeTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(60),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).backgroundColor.withOpacity(0.2),
            offset: Offset(0, -5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(
            iconNames.length,
            (index) => index == current
                ? NavSelected(
                    iconName: iconNames[index], tabName: tabNames[index])
                : NavItem(
                    iconName: iconNames[index],
                    tap: () => changeNav(index),
                  ),
          ),
        ],
      ),
    );
  }
}
