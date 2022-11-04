import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splitit/components/primarybtn.dart';

import '../../size.dart';

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
              Column(
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
                          secondaryColor:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                          padding: 20,
                          title: "Add money",
                          tap: () {
                            dialogBuilder(context, true);
                          },
                          titleColor: const Color(0xffFCF7F8),
                          hasIcon: false,
                        ),
                      ),
                      Expanded(
                        child: PrimaryBtn(
                          primaryColor: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.6),
                          secondaryColor: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.4),
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
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(getHeight(20)),
                    child: widget.transactions.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Transaction history",
                                style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                  fontSize: getHeight(18),
                                ),
                              ),
                              SizedBox(height: getHeight(20)),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                          widget.transactions.length, (index) {
                                        String text = widget.transactions[index]
                                            .split(",")
                                            .first;
                                        double amount = double.parse(widget
                                            .transactions[index]
                                            .split(",")
                                            .last);
                                        bool isAdded =
                                            text.split(" ").last == "added";

                                        return Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .backgroundColor
                                                    .withOpacity(0.04),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    getHeight(10)),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      text,
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .backgroundColor,
                                                        fontSize: getHeight(16),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      isAdded
                                                          ? "+ \u{20B9} $amount"
                                                          : "- \u{20B9} $amount",
                                                      style: TextStyle(
                                                        color: isAdded
                                                            ? Colors.greenAccent
                                                            : Colors.redAccent,
                                                        fontSize: getHeight(16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if (index !=
                                                widget.transactions.length - 1)
                                              SizedBox(height: getHeight(10)),
                                          ],
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        : Center(
                            child: Text(
                              "No transactions yet!!",
                              style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                                fontSize: getHeight(18),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.onChanged}) : super(key: key);
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    String reg = r'[0-9.]';
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
        child: TextFormField(
          style: TextStyle(color: Theme.of(context).primaryColorDark),
          onChanged: (value) => onChanged(double.parse(value)),
          validator: (value) =>
              double.tryParse(value!) == null ? "Invalid double" : null,
          keyboardType: TextInputType.number,
          inputFormatters: [
            // for below version 2 use this
            FilteringTextInputFormatter.allow(RegExp(reg)),
          ],
          cursorRadius: const Radius.circular(8),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "0.0",
            hintStyle: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: getHeight(16)),
          ),
        ),
      ),
    );
  }
}
