import 'package:flutter/material.dart';
import 'package:splitit/frontend/home/components/bill_details_nav.dart';

import '../../../backend/bill_data.dart';
import '../../../size.dart';
import '../../components/bill_footer.dart';
import '../../components/friend_card.dart';

class BillDetails extends StatelessWidget {
  const BillDetails({super.key, required this.bill});
  final Map<String, dynamic> bill;

  @override
  Widget build(BuildContext context) {
    BillData billData = BillData(bill["name"], bill["amt"], bill["isUnequal"],
        bill["amounts"], bill["friends"], bill["paidBy"], bill["paidByMe"]);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(getHeight(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BillDetailsNav(name: billData.name),
            SizedBox(height: getHeight(40)),
            Row(
              children: [
                Text(
                  "Paid by:",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: getHeight(10)),
                const Spacer(),
                Text(
                  billData.paidBy == -1
                      ? "Me"
                      : billData.friends[billData.paidBy],
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight(40)),
            Text(
              "Friends group",
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getHeight(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: getHeight(20)),
            FriendCard(
              name: "Me",
              isUnequal: false,
              focusNode: FocusNode(),
              onSubmitted: () {},
              onChanged: () {},
              index: -1,
              amount: billData.isUnequal
                  ? billData.paidByMe
                  : billData.amt / (billData.friends.length + 1),
              color: billData.paidBy == -1
                  ? Theme.of(context).primaryColor.withOpacity(0.5)
                  : Theme.of(context).primaryColorDark.withOpacity(0.05),
            ),
            SizedBox(height: getHeight(10)),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ...List.generate(
                      billData.friends.length,
                      (index) => Column(
                        children: [
                          FriendCard(
                            name: billData.friends[index],
                            isUnequal: false,
                            focusNode: FocusNode(),
                            onSubmitted: () {},
                            onChanged: () {},
                            index: index,
                            amount: billData.isUnequal
                                ? billData.amounts[index]
                                : billData.amt / (billData.friends.length + 1),
                            color: billData.paidBy == index
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5)
                                : Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.05),
                          ),
                          if (index != billData.friends.length - 1)
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
              amt: billData.amt,
              isUnequal: billData.isUnequal,
              totalAmt: billData.amt,
            ),
          ],
        ),
      ),
    );
  }
}
