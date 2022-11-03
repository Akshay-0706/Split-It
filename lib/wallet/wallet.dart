import 'package:flutter/material.dart';
import 'package:splitit/wallet/components/body.dart';

class Wallet extends StatelessWidget {
  const Wallet(
      {super.key,
      required this.balance,
      required this.setBalance,
      required this.transactions});
  final double balance;
  final Function setBalance;
  final List<String> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WalletBody(
        balance: balance,
        setBalance: setBalance,
        transactions: transactions,
      ),
    );
  }
}
