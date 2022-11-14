import 'package:flutter/material.dart';
import 'package:splitit/backend/bill.dart';

import '../../../size.dart';
import '../../components/bill_footer.dart';
import '../../components/friend_card.dart';
import 'bill_info.dart';
import 'bill_nav.dart';

class Splitter extends StatefulWidget {
  const Splitter({super.key, required this.onBillAdded});
  final Function onBillAdded;

  @override
  State<Splitter> createState() => _SplitterState();
}

class _SplitterState extends State<Splitter> {
  late Bill bill;
  String name = "";
  double amt = 0, willGet = 0, willPay = 0, paidByMe = 0, totalAmt = 0;
  bool paidByYou = true, isUnequal = false;
  int paidBy = -1;
  bool readyToSubmit = false;

  List<String> friends = [];
  List<double> amounts = [];

  bool friendsAdded = false;

  final TextEditingController controller = TextEditingController();
  final FocusNode myFocus = FocusNode();
  final List<FocusNode> focusNode = [];

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
      focusNode.add(FocusNode());
      friendsAdded = true;
    });
    focusNode[focusNode.length - 1].requestFocus();
    validator();
  }

  void validator() {
    if (name.isNotEmpty && amt != 0 && friends.isNotEmpty) {
      if (isUnequal) {
        if (totalAmt == amt) {
          setState(() {
            readyToSubmit = true;
          });
        } else {
          setState(() {
            readyToSubmit = false;
          });
        }
      } else {
        setState(() {
          readyToSubmit = true;
        });
      }
    } else {
      setState(() {
        readyToSubmit = false;
      });
    }
  }

  void billSplitter(int index, double value) {
    setState(() {
      if (index == -1) {
        totalAmt -= paidByMe;
        paidByMe = value;
        totalAmt += paidByMe;
      } else {
        totalAmt -= amounts[index];
        amounts[index] = value;
        totalAmt += amounts[index];
      }
    });
    validator();
  }

  void onSubmitted() {
    willGet = paidBy == -1
        ? isUnequal
            ? totalAmt - paidByMe
            : amt - (amt / (friends.length + 1))
        : 0.0;
    willPay = paidBy == -1
        ? 0.0
        : isUnequal
            ? paidByMe
            : amt / (friends.length + 1);
    widget.onBillAdded(willGet, willPay,
        Bill(name, amt, isUnequal, amounts, friends, paidBy, paidByMe));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    int noOfFriends = friends.length;

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
                    isUnequal = !isUnequal;
                    if (isUnequal) {
                      myFocus.requestFocus();
                      validator();
                    }
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
              if (isUnequal) {
                myFocus.requestFocus();
              }
              if (!paidByYou && paidBy != -1) {
                setState(() {
                  paidByYou = true;
                  paidBy = -1;
                });
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: FriendCard(
              name: "Me",
              amount: isUnequal ? paidByMe : amt / (noOfFriends + 1),
              isUnequal: isUnequal,
              focusNode: myFocus,
              onSubmitted: () {
                if (focusNode.isNotEmpty) {
                  focusNode[0].requestFocus();
                }
              },
              onChanged: billSplitter,
              color: paidBy == -1
                  ? Theme.of(context).primaryColor.withOpacity(0.5)
                  : Theme.of(context).primaryColorDark.withOpacity(0.05),
              index: -1,
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
                      noOfFriends,
                      (index) => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (isUnequal) {
                                focusNode[index].requestFocus();
                              }
                              if (!paidByYou && paidBy != index) {
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
                              isUnequal: isUnequal,
                              onChanged: billSplitter,
                              amount: isUnequal ? 0.0 : amt / (noOfFriends + 1),
                              color: paidBy == index
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5)
                                  : Theme.of(context)
                                      .primaryColorDark
                                      .withOpacity(0.05),
                              focusNode: focusNode[index],
                              onSubmitted: () {
                                if (index < noOfFriends - 1) {
                                  focusNode[index + 1].requestFocus();
                                }
                              },
                              index: index,
                            ),
                          ),
                          if (index != noOfFriends - 1)
                            SizedBox(height: getHeight(10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: getHeight(20)),
          BillFooter(
            isUnequal: isUnequal,
            amt: amt,
            totalAmt: totalAmt,
          ),
        ],
      ),
    ));
  }
}
