import 'package:flutter/material.dart';
import 'package:splitit/frontend/bill/components/body.dart';

class Bill extends StatelessWidget {
  const Bill({super.key, required this.onBillAdded});
  final Function onBillAdded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BillBody(
        onBillAdded: onBillAdded,
      ),
    );
  }
}
