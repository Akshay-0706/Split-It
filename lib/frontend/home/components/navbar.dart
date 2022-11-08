import 'package:flutter/material.dart';

import '../../../size.dart';
import 'nav_item.dart';
import 'nav_selected.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
    required this.changeTab,
    required this.current,
  }) : super(key: key);
  final int current;
  final Function changeTab;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  List<String> iconNames = ["home", "transfer", "wallet", "account"];

  List<String> tabNames = ["Home", "Transfer", "Wallet", "Account"];

  changeNav(index) {
    widget.changeTab(index);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).backgroundColor.withOpacity(0.2),
            offset: const Offset(0, -5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getHeight(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...List.generate(
              iconNames.length,
              (index) => index == widget.current
                  ? NavSelected(
                      iconName: iconNames[index], tabName: tabNames[index])
                  : NavItem(
                      iconName: iconNames[index],
                      tap: () => changeNav(index),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
