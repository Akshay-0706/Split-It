import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../components/primarybtn.dart';
import '../../size.dart';
import '../../wallet/components/body.dart';

class TransferBody extends StatefulWidget {
  const TransferBody(
      {super.key,
      required this.email,
      required this.balance,
      required this.name,
      required this.photo,
      required this.setBalance});
  final String name, email, photo;
  final double balance;
  final Function setBalance;

  @override
  State<TransferBody> createState() => _TransferBodyState();
}

class _TransferBodyState extends State<TransferBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final GlobalKey qrKey = GlobalKey(debugLabel: "qr");
  late QRViewController controller;
  List<String> scannedData = [];

  String mode = "qr";
  double transferMoney = 0.0;

  final tabs = [
    const Tab(text: "QR Code"),
    const Tab(text: "Scan QR"),
  ];

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid && mode == "scan") {
  //     controller.pauseCamera();
  //   }
  //   if (mode == "scan") controller.resumeCamera();
  // }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onChanged(double money) {
    transferMoney = money;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(getHeight(20)),
        child: Column(
          children: [
            SizedBox(height: getHeight(40)),
            Text(
              "QR Quick Transfer",
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getHeight(20),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: getHeight(40)),
            Container(
              height: getHeight(50),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TabBar(
                onTap: (value) {
                  setState(() {
                    mode = value == 0 ? "qr" : "scan";
                    if (mode == "qr") scannedData = [];
                  });
                  // futureIndices = fetchIndices(mode);
                  // callStock();
                },
                controller: tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.4),
                    ],
                  ),
                ),
                labelColor: const Color(0xffFCF7F8),
                labelStyle: TextStyle(
                  color: const Color(0xffFCF7F8),
                  fontSize: getHeight(16),
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor: Colors.black,
                tabs: tabs,
              ),
            ),
            SizedBox(height: getHeight(40)),
            if (mode == "qr") QRCodeGenerator(widget: widget),
            if (mode == "scan")
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: getHeight(200),
                        height: getHeight(200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: (controller) {
                              this.controller = controller;
                              controller.resumeCamera();
                              controller.scannedDataStream.listen((scanData) {
                                setState(() {
                                  scannedData.add(
                                      scanData.code!.split(",").elementAt(0));
                                  scannedData.add(
                                      scanData.code!.split(",").elementAt(1));
                                  scannedData.add(
                                      scanData.code!.split(",").elementAt(2));
                                  scannedData.add(
                                      scanData.code!.split(",").elementAt(3));
                                  controller.pauseCamera();
                                });
                              });
                            },
                          ),
                        ),
                      ),
                      if (scannedData.isEmpty)
                        Column(
                          children: [
                            SizedBox(height: getHeight(20)),
                            Text(
                              "Scanning for QR Code...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: getHeight(18),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: getHeight(20)),
                            CircularProgressIndicator(
                                color: Theme.of(context).primaryColor)
                          ],
                        ),
                      if (scannedData.isNotEmpty)
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(height: getHeight(20)),
                              Text(
                                "Transfer to:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: getHeight(18),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: getHeight(20)),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.4),
                                      offset: const Offset(1, 1),
                                      blurRadius: 10,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  borderRadius: BorderRadius.circular(35),
                                  child: CachedNetworkImage(
                                    width: getHeight(70),
                                    height: getHeight(70),
                                    imageUrl: scannedData[3],
                                    placeholder: (context, url) => Container(
                                      width: getHeight(70),
                                      height: getHeight(70),
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          shape: BoxShape.circle),
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                        strokeWidth: 8,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: getHeight(20)),
                              Text(
                                scannedData[1],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: getHeight(18),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: getHeight(20)),
                              PrimaryBtn(
                                primaryColor: Theme.of(context).primaryColor,
                                secondaryColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.4),
                                padding: 20,
                                title: "Continue",
                                tap: () {
                                  dialogBuilder(context);
                                },
                                titleColor: const Color(0xffFCF7F8),
                                hasIcon: false,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                "Transfer money",
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getHeight(20),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(onChanged: onChanged),
                  SizedBox(height: getHeight(10)),
                  PrimaryBtn(
                    primaryColor: Theme.of(context).primaryColor,
                    secondaryColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                    padding: 0,
                    title: "Done",
                    tap: () {
                      if (transferMoney <= widget.balance) {
                        widget.setBalance(widget.balance - transferMoney);
                        widget.setBalance(
                            double.parse(scannedData[0]) + transferMoney,
                            scannedData[2]);
                      }
                      Navigator.pop(context);
                    },
                    titleColor: const Color(0xffFCF7F8),
                    hasIcon: false,
                  )
                ],
              ),
              backgroundColor: Theme.of(context).backgroundColor,
            ));
  }
}

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
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
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
