import 'bill.dart';

class User {
  final String dateOfBirth;
  final int noOfFriends;
  final List<Bill> bill;

  User(this.dateOfBirth, this.noOfFriends, this.bill);

  int getNoOfFriends() => noOfFriends;
}
