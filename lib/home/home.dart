import 'package:flutter/material.dart';
import 'package:splitit/account/components/body.dart';
import 'package:splitit/home/components/body.dart';
import 'package:splitit/home/components/navbar.dart';
import 'package:splitit/transfer/components/body.dart';
import 'package:splitit/wallet/components/body.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int current = 0;

  List<Widget> tabs = [
    const HomeBody(),
    const TransferBody(),
    const WalletBody(),
    const AccountBody(),
  ];

  void changeTab(int index) {
    setState(() {
      current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[current],
      bottomNavigationBar: NavBar(changeTab: changeTab),
    );
  }
}
