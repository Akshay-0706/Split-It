import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:splitit/backend/account.dart';

import '../../../size.dart';
import 'scanner_to_transfer.dart';

class QR extends StatelessWidget {
  QR({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ScannerToTransfer widget;
  Image? QRCode;
  int? accId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          getQRCode(context),
          SizedBox(height: getHeight(20)),
          Text(
            "Ask your friend to scan this QR code",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getHeight(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            "\u{20B9} ${widget.balance}",
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getHeight(30),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "My balance",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontSize: getHeight(20),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Container getQRCode(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.4), width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: generateQRCode(context),
      ),
    );
  }

  QrImage generateQRCode(BuildContext context) {
    return QrImage(
      data: "${widget.balance},${widget.name},${widget.email},${widget.photo}",
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.02),
      foregroundColor: Theme.of(context).primaryColorDark,
      size: getHeight(200),
    );
  }
}
