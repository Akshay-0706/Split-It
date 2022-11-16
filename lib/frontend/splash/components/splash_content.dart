import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../global.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.opacity,
  }) : super(key: key);
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropShadow(
          opacity: 0.5,
          blurRadius: 7,
          offset: const Offset(0, 5),
          child: Opacity(
            opacity: opacity,
            child: SvgPicture.asset(
              "assets/icons/logo.svg",
              width: getWidth(64),
            ),
          ),
        ),
        Opacity(
          opacity: opacity,
          child: Text(
            "Split-It",
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getHeight(20),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
