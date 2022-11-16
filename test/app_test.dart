import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Transfer test", () {
    test("case 1: sufficient balance test", () {
      expect(Tester.checkSufficientBalance(1023, 835), true);
    });
    test("case 2: equal balance test", () {
      expect(Tester.checkSufficientBalance(341.8, 341.8), true);
    });
    test("case 3: insufficient balance test", () {
      expect(Tester.checkSufficientBalance(675, 2143), false);
    });
  });

  group("Withdraw test", () {
    test("case 1: sufficient balance", () {
      expect(Tester.checkSufficientBalance(170.45, 84), true);
    });
    test("case 2: equal balance", () {
      expect(Tester.checkSufficientBalance(353.2, 353.2), true);
    });
    test("case 3: insufficient balance", () {
      expect(Tester.checkSufficientBalance(432, 2575), false);
    });
  });

  group("Bill test", () {
    test("case 1: no friends added", () {
      expect(Tester.isFriendsAdded([]), false);
    });
    test("case 2: friends added", () {
      expect(Tester.isFriendsAdded(["Akshay", "Meet"]), true);
    });
  });
  group("Unequal sharing test", () {
    test("case 1: no spliting amount added", () {
      expect(Tester.isSplitingEqualsToBillAmt([], 200), false);
    });
    test("case 2: spliting amount is less than bill amount", () {
      expect(Tester.isSplitingEqualsToBillAmt([100, 50], 200), false);
    });
    test("case 3: spliting amount is more than bill amount", () {
      expect(Tester.isSplitingEqualsToBillAmt([150, 220], 200), false);
    });
    test("case 4: spliting amount is equal to bill amount", () {
      expect(Tester.isSplitingEqualsToBillAmt([130, 70], 200), true);
    });
  });
}

class Tester {
  static bool checkSufficientBalance(double balance, double transferAmt) =>
      balance >= transferAmt;

  static bool isFriendsAdded(List<String> friends) => friends.isNotEmpty;

  static bool isSplitingEqualsToBillAmt(List<double> spliting, double billAmt) {
    double splitingAmt = 0;
    for (var amt in spliting) {
      splitingAmt += amt;
    }
    return splitingAmt == billAmt;
  }
}
