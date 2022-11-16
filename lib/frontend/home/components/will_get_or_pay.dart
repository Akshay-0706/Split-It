import 'package:flutter/material.dart';

import '../../../global.dart';

class WillGetOrPay extends StatelessWidget {
  const WillGetOrPay({
    Key? key,
    required this.value,
    required this.willGet,
  }) : super(key: key);
  final double value;
  final bool willGet;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "\u{20B9} ${value.toStringAsFixed(1)}",
          style: TextStyle(
            color: willGet ? Colors.greenAccent : Colors.redAccent,
            fontSize: getHeight(16),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          willGet ? "will get" : "will pay",
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
            fontSize: getHeight(15),
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
