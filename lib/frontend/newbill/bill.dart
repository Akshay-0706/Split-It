import 'package:flutter/material.dart';
import 'package:splitit/frontend/newbill/components/body.dart';

class Bill extends StatelessWidget {
  const Bill({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BillBody(),
    );
  }
}
