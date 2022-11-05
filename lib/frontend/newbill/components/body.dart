import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../size.dart';

class BillBody extends StatefulWidget {
  const BillBody({super.key});

  @override
  State<BillBody> createState() => _BillBodyState();
}

class _BillBodyState extends State<BillBody> {
  double billAmt = 200;

  List<String> friends = [
    "Meet",
    "Divyesh",
    "Arun",
    "Arun",
    "Arun",
    "Arun",
  ];
  List<double> ammount = [
    45.53,
    265,
    231.3,
    231.3,
    231.3,
    231.3,
  ];

  bool friendsAdded = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.all(getHeight(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BillNav(),
          SizedBox(height: getHeight(40)),
          const BillInfo(),
          SizedBox(height: getHeight(20)),
          Text(
            "Add a Friend",
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getHeight(20),
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
                style: TextStyle(color: Theme.of(context).primaryColorDark),
                onFieldSubmitted: (value) {},
                keyboardType: TextInputType.number,
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
                onTap: () {},
                child: Icon(
                  Icons.check_box_outline_blank,
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
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: EdgeInsets.all(getHeight(20)),
                              child: Row(
                                children: [
                                  Text(
                                    friends[index],
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: getHeight(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "\u{20B9} ${ammount[index]}",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: getHeight(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
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
          DottedLine(
            dashColor: Theme.of(context).primaryColorDark.withOpacity(0.2),
            lineThickness: 2,
            dashRadius: 2,
            dashLength: 6,
            dashGapLength: 6,
          ),
          SizedBox(height: getHeight(20)),
          Row(
            children: [
              Text(
                "${friends.length} friends",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                "\u{20B9} $billAmt",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class BillInfo extends StatelessWidget {
  const BillInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String reg = r'[0-9.]';
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
              child: TextFormField(
                style: TextStyle(color: Theme.of(context).primaryColorDark),
                onChanged: (value) {},
                keyboardType: TextInputType.number,
                cursorRadius: const Radius.circular(8),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Bill name",
                  hintStyle: TextStyle(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.5),
                      fontSize: getHeight(16)),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: getHeight(20)),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
              child: TextFormField(
                style: TextStyle(color: Theme.of(context).primaryColorDark),
                onChanged: (value) {},
                validator: (value) =>
                    double.tryParse(value!) == null ? "Invalid double" : null,
                inputFormatters: [
                  // for below version 2 use this
                  FilteringTextInputFormatter.allow(RegExp(reg)),
                ],
                keyboardType: TextInputType.number,
                cursorRadius: const Radius.circular(8),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Price",
                  hintStyle: TextStyle(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.5),
                      fontSize: getHeight(16)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BillNav extends StatelessWidget {
  const BillNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(8),
          child: Hero(
            tag: "bill",
            child: AnimatedRotation(
              turns: 1 / 8,
              duration: const Duration(seconds: 1),
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColorDark,
                size: getHeight(26),
              ),
            ),
          ),
        ),
        const Spacer(),
        Text(
          "Add Bill",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.done,
            color: Theme.of(context).primaryColorLight.withOpacity(0.5),
            size: getHeight(26),
          ),
        ),
      ],
    );
  }
}
