class Bill {
  final String name, email = "", dateOfBirth = "";
  final double amt, paidByMe;
  final int paidBy, noOfFriends = 0;
  final bool isUnequal;
  final List<dynamic> amounts;
  final List<dynamic> friends;

  Bill(this.name, this.amt, this.isUnequal, this.amounts, this.friends,
      this.paidBy, this.paidByMe);

  int getNoOfFriends() => friends.length;
}
