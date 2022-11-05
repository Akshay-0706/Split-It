import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool databaseIsReady = false, prefIsReady = false;
  int current = 0;

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
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
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
                content: Lottie.asset("assets/extras/lottie_offline.json"),
                backgroundColor: Theme.of(context).backgroundColor,
              ),
            ),
          );
        }
      },
    );

    sharedPreferences.then((value) {
      pref = value;
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

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      HomeBody(
        balance: databaseIsReady ? balance : 0,
        photo: prefIsReady ? pref.getString("photo")! : "",
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
      ),
    ];

    return Scaffold(
      body: prefIsReady && databaseIsReady
          ? tabs[current]
          : Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColorDark,
            )),
      bottomNavigationBar:
          prefIsReady && databaseIsReady ? NavBar(changeTab: changeTab) : null,
    );
  }
}
