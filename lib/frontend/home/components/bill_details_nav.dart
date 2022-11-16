import 'package:flutter/material.dart';

import '../../../global.dart';

class BillDetailsNav extends StatelessWidget {
  const BillDetailsNav({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(8),
          child: AnimatedRotation(
            turns: 1 / 8,
            duration: const Duration(seconds: 1),
            child: Icon(
              Icons.add,
              color: Theme.of(context).primaryColorDark,
              size: getHeight(26),
            ),
          ),
        ),
        const Spacer(),
        Text(
          name,
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
