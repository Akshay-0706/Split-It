import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../size.dart';

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
          maxLength: 6,
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
            counterText: "",
            hintStyle: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: getHeight(16)),
          ),
        ),
      ),
    );
  }
}
