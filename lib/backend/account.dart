class Account {
  final String name, email;
  final int balance, accId;

  Account(this.name, this.email, this.balance, this.accId);

  getName() => name;
  getEmail() => email;
  getAccId() => accId;
}
