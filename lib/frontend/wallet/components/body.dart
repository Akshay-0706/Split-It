import 'package:flutter/material.dart';
import 'package:splitit/frontend/components/primary_btn.dart';

import '../../../size.dart';
import '../../components/custom_text_field.dart';
import 'transactions_list.dart';

class WalletBody extends StatefulWidget {
  const WalletBody(
      {super.key,
      required this.balance,
      required this.setBalance,
      required this.transactions,
      required this.addTransaction});
  final double balance;
  final Function setBalance, addTransaction;
  final List<String> transactions;

  @override
  State<WalletBody> createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> {
  double changedMoney = 0.0;

  void onChanged(double money) {
    changedMoney = money;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        builder: (context, double opacity, child) => Opacity(
          opacity: opacity,
          child: Column(
            children: [
              SizedBox(height: getHeight(40)),
              Text(
                "My Wallet",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              balanceBuilder(context),
              const Spacer(),
              TransactionsList(widget: widget),
            ],
          ),
        ),
      ),
    );
  }

  Column balanceBuilder(BuildContext context) {
    return Column(
      children: [
        Text(
          "\u{20B9} ${widget.balance}",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(30),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Total wallet balance",
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
            fontSize: getHeight(20),
          ),
        ),
        SizedBox(height: getHeight(20)),
        Row(
          children: [
            Expanded(
              child: PrimaryBtn(
                primaryColor: Theme.of(context).primaryColor,
                secondaryColor: Theme.of(context).primaryColor.withOpacity(0.8),
                padding: 20,
                title: "Add money",
                tap: () => dialogBuilder(context, true),
                titleColor: const Color(0xffFCF7F8),
                hasIcon: false,
              ),
            ),
            Expanded(
              child: PrimaryBtn(
                primaryColor: Theme.of(context).primaryColorDark,
                secondaryColor:
                    Theme.of(context).primaryColorDark.withOpacity(0.8),
                padding: 20,
                title: "Withdraw money",
                tap: () {
                  dialogBuilder(context, false);
                },
                titleColor: Theme.of(context).backgroundColor,
                hasIcon: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<dynamic> dialogBuilder(BuildContext context, bool toAdd) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                "Add money",
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getHeight(20),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(onChanged: onChanged),
                  SizedBox(height: getHeight(10)),
                  PrimaryBtn(
                    primaryColor: Theme.of(context).primaryColor,
                    secondaryColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                    padding: 0,
                    title: "Done",
                    tap: () {
                      if (toAdd && changedMoney > 0 ||
                          !toAdd && changedMoney <= widget.balance) {
                        widget.setBalance(toAdd
                            ? widget.balance + changedMoney
                            : widget.balance - changedMoney);
                        widget.addTransaction(toAdd
                            ? "Money added,$changedMoney"
                            : "Money withdrawn,$changedMoney");
                      }
                      Navigator.pop(context);
                    },
                    titleColor: const Color(0xffFCF7F8),
                    hasIcon: false,
                  )
                ],
              ),
              backgroundColor: Theme.of(context).backgroundColor,
            ));
  }
}
