class BillData {
  final String name;
  final double amt;
  final int paidBy;
  final bool isUnequal;
  final List<dynamic> amounts;
  final List<dynamic> friends;

  BillData(this.name, this.amt, this.isUnequal, this.amounts, this.friends,
      this.paidBy);
}
