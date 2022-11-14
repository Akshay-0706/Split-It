import 'package:flutter/material.dart';
import 'package:splitit/frontend/bill/components/splitter.dart';

class BillCreater extends StatelessWidget {
  const BillCreater({super.key, required this.onBillAdded});
  final Function onBillAdded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Splitter(
        onBillAdded: onBillAdded,
      ),
    );
  }
}
