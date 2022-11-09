import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:splitit/frontend/home/components/bill_details.dart';

import '../../components/custom_page_route.dart';
import '../../bill/bill.dart';
import '../../../size.dart';

class Bills extends StatefulWidget {
  const Bills({
    Key? key,
    required this.bills,
    required this.onBillAdded,
  }) : super(key: key);
  final List<Map<String, dynamic>> bills;
  final Function onBillAdded;

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: widget.bills.isEmpty
                ? Center(
                    child: Text(
                      "No bills added",
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontSize: getHeight(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(getHeight(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bills",
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: getHeight(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: getHeight(20)),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                ...billCard(context),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                CustomPageRoute(
                  context,
                  Bill(onBillAdded: widget.onBillAdded),
                ),
              ),
              backgroundColor: Theme.of(context).backgroundColor,
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> billCard(BuildContext context) {
    return List.generate(
      widget.bills.length,
      (index) => Column(
        children: [
          OpenContainer(
            closedElevation: 0,
            openElevation: 0,
            openColor: Theme.of(context).backgroundColor,
            closedColor: Theme.of(context).backgroundColor.withOpacity(0.1),
            closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            transitionType: ContainerTransitionType.fadeThrough,
            closedBuilder: (context, action) => InkWell(
              onTap: action,
              child: Padding(
                padding: EdgeInsets.all(getHeight(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: getHeight(10)),
                        Text(
                          widget.bills[index]["name"],
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: getHeight(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "\u{20B9} ${widget.bills[index]["amt"]}",
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: getHeight(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: getHeight(10)),
                      ],
                    ),
                    addFriends(context, index),
                  ],
                ),
              ),
            ),
            openBuilder: (context, action) => BillDetails(
              bill: widget.bills[index],
            ),
          ),
          if (index != widget.bills.length - 1) SizedBox(height: getHeight(10)),
        ],
      ),
    );
  }

  Padding addFriends(BuildContext context, int index) {
    final List<dynamic> friends = widget.bills[index]["friends"];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            Text(
              "Friends: ",
              style: TextStyle(
                color: Theme.of(context).backgroundColor.withOpacity(0.7),
                fontSize: getHeight(14),
              ),
            ),
            ...List.generate(
              friends.length,
              (friendsIndex) => Text(
                friends[friendsIndex] +
                    ((friendsIndex != friends.length - 1) ? ", " : ""),
                style: TextStyle(
                  color: Theme.of(context).backgroundColor.withOpacity(0.7),
                  fontSize: getHeight(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
