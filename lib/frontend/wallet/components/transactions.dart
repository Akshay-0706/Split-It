import 'package:flutter/material.dart';

import '../../../global.dart';
import 'body.dart';

class Transactions extends StatelessWidget {
  const Transactions({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final WalletBody widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ...List.generate(widget.transactions.length, (index) {
              String text = widget.transactions[index].split(",").first;
              double amount =
                  double.parse(widget.transactions[index].split(",").last);
              bool isAdded = text.split(" ").last == "added";

              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).backgroundColor.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(getHeight(10)),
                      child: Row(
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                              color: Theme.of(context).backgroundColor,
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
                  if (index != widget.transactions.length - 1)
                    SizedBox(height: getHeight(10)),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
