import 'package:flutter/cupertino.dart';

class Receiver {
  final Image QRCode;

  Receiver(this.QRCode);

  checkBalance(int userBalance, int transferAmt) => userBalance >= transferAmt;
}
