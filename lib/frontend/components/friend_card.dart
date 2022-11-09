import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../size.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    Key? key,
    required this.name,
    required this.amount,
    required this.index,
    required this.color,
    required this.isUnequal,
    required this.focusNode,
    required this.onChanged,
    required this.onSubmitted,
  }) : super(key: key);
  final Color color;
  final String name;
  final int index;
  final double amount;
  final bool isUnequal;
  final FocusNode focusNode;
  final Function onChanged, onSubmitted;

  @override
  Widget build(BuildContext context) {
    String reg = r'[0-9.]';

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
              "\u{20B9} ",
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getHeight(16),
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!isUnequal)
              Text(
                amount.toStringAsFixed(2),
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (isUnequal)
              SizedBox(
                width: getHeight(37),
                child: TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
                  focusNode: focusNode,
                  onChanged: (value) => onChanged(index, value == "" ? 0.0 : double.parse(value)),
                  onFieldSubmitted: (value) => onSubmitted(),
                  validator: (value) =>
                      double.tryParse(value!) == null ? "Invalid double" : null,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // for below version 2 use this
                    FilteringTextInputFormatter.allow(RegExp(reg)),
                  ],
                  cursorRadius: const Radius.circular(8),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: "0.00",
                    hintStyle: TextStyle(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.7),
                      fontSize: getHeight(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
