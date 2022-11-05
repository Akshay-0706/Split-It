import 'package:flutter/material.dart';
import 'package:splitit/frontend/transfer/components/body.dart';

class Transfer extends StatelessWidget {
  const Transfer(
      {super.key,
      required this.email,
      required this.balance,
      required this.name,
      required this.photo,
      required this.setBalance});
  final String name, email, photo;
  final double balance;
  final Function setBalance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransferBody(
        name: name,
        email: email,
        photo: photo,
        balance: balance,
        setBalance: setBalance,
      ),
    );
  }
}
