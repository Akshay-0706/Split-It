import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitit/backend/bill_data.dart';
import 'package:splitit/backend/bill_decoder.dart';
import 'package:splitit/backend/bill_encoder.dart';
import 'package:splitit/frontend/home/components/body.dart';
import 'package:splitit/frontend/home/components/navbar.dart';
import 'package:splitit/global.dart';
import 'package:url_launcher/url_launcher.dart';

import '../account/account.dart';
import '../../backend/database.dart';
import '../components/primary_btn.dart';
import '../transfer/transfer.dart';
import '../wallet/wallet.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseDatabase databaseRef = FirebaseDatabase.instance;
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  late SharedPreferences pref;
  late double balance, willGet, willPay;
  late List<String> transactions;
  late List<Map<String, dynamic>> bills;
  bool isDialogShowing = false, databaseIsReady = false, prefIsReady = false;
  int current = 0;
  late StreamSubscription streamSubscription;

  void changeTab(int index) {
    setState(() {
      current = index;
    });
  }

  void changeTheme(String theme) {
    pref.setString("theme", theme);
  }

  @override
  void initState() {
    WidgetsBinding.instance.window.onPlatformBrightnessChanged = () {
      setState(() {
        themeChanger.isDarkMode =
            themeChanger.currentTheme() == ThemeMode.system
                ? WidgetsBinding.instance.window.platformBrightness ==
                    Brightness.dark
                : themeChanger.currentTheme() == ThemeMode.dark;
      });
    };
    Database.getLatestVersion(databaseRef)
        .then((latestVersion) => PackageInfo.fromPlatform().then((packageInfo) {
              if (packageInfo.version != latestVersion) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      title: Text(
                        "An update is available",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: getHeight(20),
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset(
                            themeChanger.isDarkMode
                                ? "assets/extras/lottie_update_dark.json"
                                : "assets/extras/lottie_update_light.json",
                            width: getHeight(120),
                            height: getHeight(120),
                          ),
                          Text(
                            "Latest version: $latestVersion",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.8),
                              fontSize: getHeight(14),
                            ),
                          ),
                          SizedBox(height: getHeight(5)),
                          Text(
                            "Current version: ${packageInfo.version}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.8),
                              fontSize: getHeight(14),
                            ),
                          ),
                          SizedBox(height: getHeight(10)),
                          PrimaryBtn(
                            primaryColor: Theme.of(context).primaryColorDark,
                            secondaryColor: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.8),
                            padding: 20,
                            title: "Update app",
                            tap: () => launchUrl(Uri.parse(
                                "https://drive.google.com/drive/folders/1F2kGvGIdpgGxSna5V6R_WtegFi_GRFEE?usp=sharing")),
                            titleColor: Theme.of(context).backgroundColor,
                            hasIcon: false,
                          ),
                        ],
                      ),
                      backgroundColor: Theme.of(context).backgroundColor,
                    ),
                  ),
                );
              }
            }));

    streamSubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (isDialogShowing &&
            (result == ConnectivityResult.mobile ||
                result == ConnectivityResult.wifi)) {
          isDialogShowing = false;
          Navigator.pop(context);
        } else if (result != ConnectivityResult.mobile &&
            result != ConnectivityResult.wifi) {
          isDialogShowing = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                title: Text(
                  "You are offline",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(20),
                  ),
                ),
                content: Lottie.asset(
                    themeChanger.isDarkMode
                        ? "assets/extras/lottie_offline_dark.json"
                        : "assets/extras/lottie_offline_light.json",
                    width: getHeight(120),
                    height: getHeight(120)),
                backgroundColor: Theme.of(context).backgroundColor,
              ),
            ),
          );
        }
      },
    );

    sharedPreferences.then((value) {
      pref = value;

      willGet = pref.getDouble("willGet")!;
      willPay = pref.getDouble("willPay")!;

      bills = BillDecoder.fromStringList(pref.getStringList("bills")!).data;

      if (pref.containsKey("theme") && pref.getString("theme") != "Auto") {
        themeChanger.isDarkMode = pref.getString("theme") == "Dark";
      }

      Database.getBalance(databaseRef, pref.getString("email")!).then((value) {
        balance = value;
        setState(() {
          databaseIsReady = true;
        });
      });
      databaseRef
          .ref(pref.getString("email")!.replaceAll(".", "_"))
          .onValue
          .listen(
        (event) {
          setState(() {
            balance = double.parse(event.snapshot.value.toString());
          });
        },
      );

      setState(() {
        prefIsReady = true;
      });

      transactions = pref.getStringList("transactions")!;
    });

    super.initState();
  }

  void setBalance(double newBalance, [String? email]) {
    Database.setBalance(
        databaseRef, email ?? pref.getString("email")!, newBalance);
  }

  void addTransaction(String transaction) {
    setState(() {
      transactions.add(transaction);
    });
    pref.setStringList("transactions", transactions);
  }

  void onBillAdded(double willGet, double willPay, BillData billData) {
    Map<String, dynamic> bill = {
      "name": billData.name,
      "amt": billData.amt,
      "paidBy": billData.paidBy,
      "paidByMe": billData.paidByMe,
      "isUnequal": billData.isUnequal,
      "amounts": billData.amounts,
      "friends": billData.friends
    };
    setState(() {
      bills.add(bill);
      this.willGet += willGet;
      this.willPay += willPay;
    });
    pref.setStringList("bills", BillEncoder.fromJsonList(bills).data);
    pref.setDouble("willGet", this.willGet);
    pref.setDouble("willPay", this.willPay);

    snackBarBuilder(context, "${billData.name} bill added", Colors.greenAccent);
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      HomeBody(
        willGet: prefIsReady ? willGet : 0.0,
        willPay: prefIsReady ? willPay : 0.0,
        balance: databaseIsReady ? balance : 0.0,
        photo: prefIsReady ? pref.getString("photo")! : "",
        bills: prefIsReady ? bills : [],
        changeTab: changeTab,
        onBillAdded: onBillAdded,
      ),
      Transfer(
        name: prefIsReady ? pref.getString("name")! : "",
        email: prefIsReady ? pref.getString("email")! : "",
        photo: prefIsReady ? pref.getString("photo")! : "",
        balance: databaseIsReady ? balance : 0,
        setBalance: setBalance,
        changeTab: changeTab,
      ),
      Wallet(
        balance: databaseIsReady ? balance : 0,
        setBalance: setBalance,
        transactions: prefIsReady ? transactions : [],
        addTransaction: addTransaction,
        changeTab: changeTab,
      ),
      Account(
        name: prefIsReady ? pref.getString("name")! : "",
        email: prefIsReady ? pref.getString("email")! : "",
        photo: prefIsReady ? pref.getString("photo")! : "",
        theme: prefIsReady ? pref.getString("theme")! : "Auto",
        changeTheme: changeTheme,
        changeTab: changeTab,
      ),
    ];

    return Scaffold(
      body: prefIsReady && databaseIsReady
          ? tabs[current]
          : Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColorDark,
            )),
      bottomNavigationBar: prefIsReady && databaseIsReady
          ? NavBar(current: current, changeTab: changeTab)
          : null,
    );
  }
}
