import 'package:flutter/material.dart';
import 'package:splitit/frontend/transfer/components/scanner_to_transfer.dart';

class Transfer extends StatelessWidget {
  const Transfer(
      {super.key,
      required this.email,
      required this.balance,
      required this.name,
      required this.photo,
      required this.setBalance,
      required this.changeTab});
  final String name, email, photo;
  final double balance;
  final Function setBalance, changeTab;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => changeTab(0),
      child: Scaffold(
        body: ScannerToTransfer(
          name: name,
          email: email,
          photo: photo,
          balance: balance,
          setBalance: setBalance,
        ),
      ),
    );
  }
}
