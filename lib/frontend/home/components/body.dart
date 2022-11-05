import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:splitit/size.dart';

import 'bills.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
    required this.balance,
    required this.photo,
  });
  final double balance;
  final String photo;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Map<dynamic, dynamic>> bills = [
        {"name": "New bill", "amount": 203},
        {"name": "New bill", "amount": 203},
        {"name": "New bill", "amount": 203},
        {"name": "New bill", "amount": 203},
        {"name": "New bill", "amount": 203},
        {"name": "New bill", "amount": 203},
        {"name": "New bill", "amount": 203},
      ],
      people = [
        {
          0: "Akshay",
          1: "Meet",
          2: "Meet",
          3: "Meet",
          4: "Meet",
          5: "Meet",
          6: "Meet",
          7: "Meet",
          8: "Meet",
          9: "Meet",
        },
        {0: "Akshay", 1: "Meet"},
        {0: "Akshay", 1: "Meet"},
        {0: "Akshay", 1: "Meet"},
        {0: "Akshay", 1: "Meet"},
        {0: "Akshay", 1: "Meet"},
        {0: "Akshay", 1: "Meet"},
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        builder: (context, double opacity, child) => Opacity(
          opacity: opacity,
          child: Column(
            children: [
              SizedBox(height: getHeight(40)),
              navBarBuilder(context),
              SizedBox(height: getHeight(40)),
              balanceCardBuilder(context),
              SizedBox(height: getHeight(40)),
              Bills(bills: bills, people: people),
            ],
          ),
        ),
      ),
    );
  }

  Padding navBarBuilder(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Split-It",
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getHeight(20),
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.4),
                    offset: const Offset(1, 1),
                    blurRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  width: getHeight(40),
                  height: getHeight(40),
                  imageUrl: widget.photo,
                  placeholder: (context, url) => Container(
                    width: getHeight(40),
                    height: getHeight(40),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        shape: BoxShape.circle),
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 8,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error_outline,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              )
              // : CircularProgressIndicator(
              //     color: Theme.of(context).primaryColorDark,
              //   ),
              )
        ],
      ),
    );
  }

  Padding balanceCardBuilder(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(getHeight(20)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total balance: ",
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontSize: getHeight(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // if (balanceIsReady)
                  Text(
                    "\u{20B9} ${widget.balance}",
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontSize: getHeight(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // if (!balanceIsReady)
                  //   CircularProgressIndicator(
                  //     color: Theme.of(context).backgroundColor,
                  //   )
                ],
              ),
              SizedBox(height: getHeight(20)),
              DottedLine(
                dashColor: Theme.of(context).backgroundColor.withOpacity(0.5),
                lineThickness: 2,
                dashRadius: 2,
                dashLength: 6,
                dashGapLength: 6,
              ),
              SizedBox(height: getHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  WillGetOrPay(
                    value: 0,
                    willGet: true,
                  ),
                  WillGetOrPay(
                    value: 0,
                    willGet: false,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WillGetOrPay extends StatelessWidget {
  const WillGetOrPay({
    Key? key,
    required this.value,
    required this.willGet,
  }) : super(key: key);
  final double value;
  final bool willGet;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "\u{20B9} $value",
          style: TextStyle(
            color: willGet ? Colors.greenAccent : Colors.redAccent,
            fontSize: getHeight(16),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          willGet ? "will get" : "will pay",
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
            fontSize: getHeight(15),
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
