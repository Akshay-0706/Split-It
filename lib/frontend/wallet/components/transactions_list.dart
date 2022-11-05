import 'package:flutter/material.dart';

import '../../../size.dart';
import 'body.dart';
import 'transactions.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final WalletBody widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    Transactions(widget: widget)
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
    );
  }
}
