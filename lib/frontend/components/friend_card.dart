import 'package:flutter/material.dart';

import '../../size.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    Key? key,
    required this.name,
    required this.amount,
    required this.color,
  }) : super(key: key);

  final Color color;
  final String name;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(getHeight(20)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Text(
              "\u{20B9} ${amount.toStringAsFixed(2)}",
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getHeight(16),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
