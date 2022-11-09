import 'package:firebase_database/firebase_database.dart';

class Database {
  static Future<double> getBalance(
      FirebaseDatabase databaseRef, String email) async {
    late double balance;
    await databaseRef.ref(email.replaceAll(".", "_")).get().then(
      (snapshot) {
        if (snapshot.exists) {
          balance = double.parse(snapshot.value.toString());
        } else {
          databaseRef.ref(email.replaceAll(".", "_")).set(0);
          balance = 0;
        }
      },
    ).catchError((error) => throw error);
    return balance;
  }

  static void setBalance(
      FirebaseDatabase databaseRef, String email, double balance) async {
    await databaseRef
        .ref(email.replaceAll(".", "_"))
        .set(balance)
        .then(
          (snapshot) {},
        )
        .catchError((error) => throw error);
  }

  static Future<String> getLatestVersion(FirebaseDatabase databaseRef) async {
    late String version;
    await databaseRef.ref("version").get().then(
      (snapshot) {
        version = snapshot.value.toString();
      },
    ).catchError((error) => throw error);
    return version;
  }
}
