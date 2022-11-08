import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitit/backend/bill_data.dart';
import 'package:splitit/backend/bill_decoder.dart';
import 'package:splitit/backend/bill_encoder.dart';
import 'package:splitit/frontend/home/components/body.dart';
import 'package:splitit/frontend/home/components/navbar.dart';

import '../account/account.dart';
import '../../backend/database.dart';
import '../../size.dart';
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
  late double balance;
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
    streamSubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (isDialogShowing && (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi)) {
          isDialogShowing = false;
          Navigator.pop(context);
        } else if (result == ConnectivityResult.none) {
          isDialogShowing = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(
                  "You are offline",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: getHeight(20),
                  ),
                ),
                content: Lottie.asset("assets/extras/lottie_offline.json",
                    width: getHeight(120), height: getHeight(120)),
                backgroundColor: Theme.of(context).backgroundColor,
              ),
            ),
          );
        }
      },
    );

    sharedPreferences.then((value) {
      pref = value;

      bills = BillDecoder.fromStringList(pref.getStringList("bills")!).data;

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

  void onBillAdded(BillData billData) {
    Map<String, dynamic> bill = {
      "name": billData.name,
      "amt": billData.amt,
      "paidBy": billData.paidBy,
      "isUnequal": billData.isUnequal,
      "amounts": billData.amounts,
      "friends": billData.friends
    };
    setState(() {
      bills.add(bill);
    });
    pref.setStringList("bills", BillEncoder.fromJsonList(bills).data);
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
        balance: databaseIsReady ? balance : 0,
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
      ),
      Wallet(
        balance: databaseIsReady ? balance : 0,
        setBalance: setBalance,
        transactions: prefIsReady ? transactions : [],
        addTransaction: addTransaction,
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
