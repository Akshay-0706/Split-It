import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../size.dart';

class BillFooter extends StatelessWidget {
  const BillFooter({
    Key? key,
    required this.amt,
  }) : super(key: key);

  final double amt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedLine(
          dashColor: Theme.of(context).primaryColorDark.withOpacity(0.2),
          lineThickness: 2,
          dashRadius: 2,
          dashLength: 6,
          dashGapLength: 6,
        ),
        SizedBox(height: getHeight(20)),
        Row(
          children: [
            Text(
              "Total:",
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getHeight(16),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            SizedBox(width: getHeight(10)),
            Text(
              "\u{20B9} ${amt.toStringAsFixed(2)}",
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getHeight(16),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}