import 'package:flutter/material.dart';
import 'package:splitit/size.dart';
import 'package:splitit/frontend/splash/components/body.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    return const Scaffold(
      body: SplashBody(),
    );
  }
}
