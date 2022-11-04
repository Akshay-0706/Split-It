import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../size.dart';

class NavSelected extends StatefulWidget {
  const NavSelected({
    Key? key,
    required this.iconName,
    required this.tabName,
  }) : super(key: key);
  final String iconName, tabName;

  @override
  State<NavSelected> createState() => _NavSelectedState();
}

class _NavSelectedState extends State<NavSelected> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, double opacity, child) => Opacity(
        opacity: opacity,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    widget.iconName == "transfer"
                        ? "assets/icons/${widget.iconName}.svg"
                        : "assets/icons/${widget.iconName}Selected.svg",
                    color: Theme.of(context).primaryColorDark,
                    width: getWidth(18),
                  ),
                  SizedBox(
                    width: getWidth(10),
                  ),
                  Text(
                    widget.tabName,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: getHeight(16),
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
