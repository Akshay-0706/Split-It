import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../global.dart';
import 'bills.dart';
import 'will_get_or_pay.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
    required this.balance,
    required this.willGet,
    required this.willPay,
    required this.photo,
    required this.changeTab,
    required this.bills,
    required this.onBillAdded,
  });
  final double balance, willGet, willPay;
  final String photo;
  final Function changeTab, onBillAdded;
  final List<Map<String, dynamic>> bills;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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
              Bills(bills: widget.bills, onBillAdded: widget.onBillAdded),
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
          InkWell(
            onTap: () => widget.changeTab(3),
            borderRadius: BorderRadius.circular(20),
            child: Hero(
              tag: "Photo",
              child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.4),
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
                  ),
            ),
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
                children: [
                  WillGetOrPay(value: widget.willGet, willGet: true),
                  WillGetOrPay(value: widget.willPay, willGet: false),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
