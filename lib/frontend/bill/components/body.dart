import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splitit/backend/bill_data.dart';

import '../../../size.dart';
import '../../components/bill_footer.dart';
import '../../components/friend_card.dart';
import 'bill_info.dart';
import 'bill_nav.dart';

class BillBody extends StatefulWidget {
  const BillBody({super.key, required this.onBillAdded});
  final Function onBillAdded;

  @override
  State<BillBody> createState() => _BillBodyState();
}

class _BillBodyState extends State<BillBody> {
  late BillData billData;
  String name = "";
  double amt = 0, totalAmt = 0;
  bool paidByYou = true, isUnequal = false;
  int paidBy = -1;
  bool readyToSubmit = false;

  List<String> friends = [];
  List<double> amounts = [];

  bool friendsAdded = false;

  final TextEditingController controller = TextEditingController();

  void onChangedBillName(String name) {
    this.name = name;
    validator();
  }

  void onChangedPrice(double amt) {
    setState(() {
      this.amt = amt;
    });
    validator();
  }

  void onFriendAdded(String name) {
    setState(() {
      friends.add(name);
      amounts.add(0.0);
      totalAmt += amt / (friends.length + 1);
      friendsAdded = true;
    });
    validator();
  }

  void validator() {
    if (name.isEmpty) {
      print("name is empty");
    }
    if (amt == 0) {
      print("amt is empty");
    }
    if (friends.isEmpty) {
      print("friends is empty");
    }
    if (name.isNotEmpty && amt != 0 && friends.isNotEmpty) {
      setState(() {
        readyToSubmit = true;
      });
    }
  }

  void onSubmitted() {
    widget
        .onBillAdded(BillData(name, amt, isUnequal, amounts, friends, paidBy));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.all(getHeight(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BillNav(readyToSubmit: readyToSubmit, onSubmitted: onSubmitted),
          SizedBox(height: getHeight(40)),
          BillInfo(
            onChangedBillName: onChangedBillName,
            onChangedPrice: onChangedPrice,
          ),
          SizedBox(height: getHeight(20)),
          Text(
            "Add a friend",
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getHeight(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: getHeight(20)),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
              child: TextFormField(
                controller: controller,
                style: TextStyle(color: Theme.of(context).primaryColorDark),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    onFriendAdded(value);
                    controller.text = "";
                  }
                },
                keyboardType: TextInputType.text,
                cursorRadius: const Radius.circular(8),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Friend's name",
                  hintStyle: TextStyle(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.5),
                      fontSize: getHeight(16)),
                ),
              ),
            ),
          ),
          SizedBox(height: getHeight(20)),
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    print("Paid by you clicked");
                    paidByYou = !paidByYou;
                    paidBy = paidByYou ? -1 : 0;
                  });
                },
                child: Icon(
                  paidByYou ? Icons.check_box : Icons.check_box_outline_blank,
                  color: Theme.of(context).primaryColorDark,
                  size: getHeight(20),
                ),
              ),
              SizedBox(width: getHeight(10)),
              Text(
                "Paid by you",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              SizedBox(width: getHeight(20)),
              InkWell(
                onTap: () {
                  setState(() {
                    print("Unequal sharing clicked");
                    isUnequal = !isUnequal;
                  });
                },
                child: Icon(
                  isUnequal ? Icons.check_box : Icons.check_box_outline_blank,
                  color: Theme.of(context).primaryColorDark,
                  size: getHeight(20),
                ),
              ),
              SizedBox(width: getHeight(10)),
              Text(
                "Unequal sharing",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: getHeight(20)),
          InkWell(
            onTap: () {
              if (!paidByYou && paidBy != -1) {
                print("Click done");
                setState(() {
                  paidByYou = true;
                  paidBy = -1;
                });
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: FriendCard(
              name: "Me",
              amount: isUnequal ? 0.0 : amt / (friends.length + 1),
              color: paidBy == -1
                  ? Theme.of(context).primaryColor.withOpacity(0.5)
                  : Theme.of(context).primaryColorDark.withOpacity(0.05),
            ),
          ),
          SizedBox(height: getHeight(10)),
          if (!friendsAdded)
            Expanded(
              child: Center(
                child: Text(
                  "No friends added",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: getHeight(16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (friendsAdded)
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ...List.generate(
                      friends.length,
                      (index) => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (!paidByYou && paidBy != index) {
                                print("Click done");
                                setState(() {
                                  paidBy = index;
                                });
                              } else {
                                setState(() {
                                  paidByYou = false;
                                  paidBy = index;
                                });
                              }
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: FriendCard(
                              name: friends[index],
                              amount:
                                  isUnequal ? 0.0 : amt / (friends.length + 1),
                              color: paidBy == index
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5)
                                  : Theme.of(context)
                                      .primaryColorDark
                                      .withOpacity(0.05),
                            ),
                          ),
                          if (index != friends.length - 1)
                            SizedBox(height: getHeight(10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: getHeight(20)),
          BillFooter(amt: amt),
        ],
      ),
    ));
  }
}
