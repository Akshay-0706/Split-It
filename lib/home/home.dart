import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitit/home/components/body.dart';
import 'package:splitit/home/components/navbar.dart';

import '../account/account.dart';
import '../backend/database.dart';
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
  int current = 2;

  void changeTab(int index) {
    setState(() {
      current = index;
    });
  }

  @override
  void initState() {
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

  void setBalance(double newBalance) {
    Database.setBalance(databaseRef, pref.getString("email")!, newBalance);
  }

  void addTransactions(String transaction) {
    transactions.add(transaction);
    pref.setStringList("transaction", transactions);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      HomeBody(
        balance: databaseIsReady ? balance : 0,
        photo: prefIsReady ? pref.getString("photo")! : "",
      ),
      const Transfer(),
      Wallet(
        balance: databaseIsReady ? balance : 0,
        setBalance: setBalance,
        transactions: prefIsReady ? transactions : [],
      ),
      const Account(),
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
