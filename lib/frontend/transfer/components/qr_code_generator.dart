import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../global.dart';
import 'body.dart';

class QRCodeGenerator extends StatelessWidget {
  const QRCodeGenerator({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final TransferBody widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                  width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: QrImage(
                data:
                    "${widget.balance},${widget.name},${widget.email},${widget.photo}",
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.02),
                foregroundColor: Theme.of(context).primaryColorDark,
                size: getHeight(200),
              ),
            ),
          ),
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
}
