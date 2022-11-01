import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:splitit/size.dart';
import 'package:splitit/splash/components/body.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    return Scaffold(
      body: SplashBody(),
    );
  }
}
