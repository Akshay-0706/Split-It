import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../components/primary_btn.dart';
import '../../../global.dart';
import '../../components/custom_text_field.dart';
import 'camera_borders.dart';
import 'qr_code_generator.dart';

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
  bool controllerIsReady = false;
  List<String> scannedData = [];

  String mode = "qr";
  double transferMoney = 0.0;

  final tabs = [
    const Tab(text: "QR Code"),
    const Tab(text: "Scan QR"),
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    if (controllerIsReady) controller.dispose();
    super.dispose();
  }

  void onChanged(double money) {
    transferMoney = money;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        builder: (context, double opacity, child) => Opacity(
          opacity: opacity,
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
                qrTabs(context),
                SizedBox(height: getHeight(40)),
                if (mode == "qr") QRCodeGenerator(widget: widget),
                if (mode == "scan") qrScanner(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container qrTabs(BuildContext context) {
    return Container(
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
    );
  }

  Expanded qrScanner(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const CameraBorders(
                  top: 0,
                  left: 0,
                  right: null,
                  bottom: null,
                ),
                const CameraBorders(
                  top: 0,
                  left: null,
                  right: 0,
                  bottom: null,
                ),
                const CameraBorders(
                  top: null,
                  left: 0,
                  right: null,
                  bottom: 0,
                ),
                const CameraBorders(
                  top: null,
                  left: null,
                  right: 0,
                  bottom: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: getHeight(200),
                    height: getHeight(200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: QRView(
                        key: qrKey,
                        onQRViewCreated: (controller) async {
                          this.controller = controller;
                          controllerIsReady = true;
                          if (await Permission.camera.isDenied) {
                            openAppSettings();
                          } else {
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
                                if (scannedData[2] != widget.email) {
                                  controller.pauseCamera();
                                }
                              });
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
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
            if (scannedData.isNotEmpty && scannedData[2] == widget.email)
              Column(
                children: [
                  SizedBox(height: getHeight(20)),
                  Text(
                    "Self transfer is meaningless,\nPlease scan different QR Code",
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
            if (scannedData.isNotEmpty && scannedData[2] != widget.email)
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
                                color: Theme.of(context).backgroundColor,
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
                      secondaryColor:
                          Theme.of(context).primaryColor.withOpacity(0.4),
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
                      if (transferMoney > widget.balance) {
                        snackBarBuilder(context, "Insuffiecient balance!",
                            Colors.redAccent);
                      }
                      if (transferMoney <= widget.balance) {
                        widget.setBalance(widget.balance - transferMoney);
                        widget.setBalance(
                            double.parse(scannedData[0]) + transferMoney,
                            scannedData[2]);

                        snackBarBuilder(
                            context,
                            "Transferred \u{20B9} $transferMoney",
                            Colors.greenAccent);
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
