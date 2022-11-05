import 'package:flutter/material.dart';

import '../../components/custom_page_route.dart';
import '../../newbill/bill.dart';
import '../../../size.dart';

class Bills extends StatefulWidget {
  const Bills({
    Key? key,
    required this.bills,
    required this.people,
  }) : super(key: key);

  final List<Map> bills;
  final List<Map> people;

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
            child: Padding(
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
              heroTag: "bill",
              onPressed: () => Navigator.push(
                  context, CustomPageRoute(context, const Bill())),
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
      (index) => InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8)),
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
                          "\u{20B9} ${widget.bills[index]["amount"]}",
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: getHeight(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: getHeight(10)),
                      ],
                    ),
                    addPeople(context, index),
                  ],
                ),
              ),
            ),
            if (index != widget.bills.length - 1)
              SizedBox(height: getHeight(10)),
          ],
        ),
      ),
    );
  }

  Padding addPeople(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            Text(
              "People: ",
              style: TextStyle(
                color: Theme.of(context).backgroundColor.withOpacity(0.7),
                fontSize: getHeight(14),
              ),
            ),
            ...List.generate(
              widget.people[index].length,
              (peopleIndex) => Text(
                widget.people[index][peopleIndex] +
                    ((peopleIndex != widget.people[index].length - 1)
                        ? ", "
                        : ""),
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
