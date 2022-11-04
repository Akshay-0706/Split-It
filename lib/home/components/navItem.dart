import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../size.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    required this.iconName,
    required this.tap,
  }) : super(key: key);
  final String iconName;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.all(getWidth(10)),
        child: SvgPicture.asset(
          "assets/icons/$iconName.svg",
          color: Theme.of(context).backgroundColor,
          width: getHeight(18),
        ),
      ),
    );
  }
}
