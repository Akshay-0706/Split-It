import 'package:flutter/material.dart';
import 'package:splitit/frontend/wallet/components/body.dart';

class Wallet extends StatelessWidget {
  const Wallet(
      {super.key,
      required this.balance,
      required this.setBalance,
      required this.transactions,
      required this.addTransaction,
      required this.changeTab});
  final double balance;
  final Function setBalance, addTransaction, changeTab;
  final List<String> transactions;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => changeTab(0),
      child: Scaffold(
        body: WalletBody(
          balance: balance,
          setBalance: setBalance,
          transactions: transactions,
          addTransaction: addTransaction,
        ),
      ),
    );
  }
}
