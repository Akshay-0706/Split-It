import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';
import '../../components/primary_btn.dart';

class Receiver extends StatelessWidget {
  const Receiver({
    Key? key,
    required this.scannedData,
    required this.onTap,
  }) : super(key: key);
  final List<String> scannedData;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: getHeight(20)),
          Text(
            "Transfer to:",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getHeight(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: getHeight(20)),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColorDark.withOpacity(0.4),
                  offset: const Offset(1, 1),
                  blurRadius: 10,
                )
              ],
              borderRadius: BorderRadius.circular(35),
            ),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(35),
              child: CachedNetworkImage(
                width: getHeight(70),
                height: getHeight(70),
                imageUrl: scannedData[3],
                placeholder: (context, url) => Container(
                  width: getHeight(70),
                  height: getHeight(70),
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
            ),
          ),
          SizedBox(height: getHeight(20)),
          Text(
            scannedData[1],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getHeight(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: getHeight(20)),
          PrimaryBtn(
            primaryColor: Theme.of(context).primaryColor,
            secondaryColor: Theme.of(context).primaryColor.withOpacity(0.4),
            padding: 20,
            title: "Continue",
            tap: onTap,
            titleColor: const Color(0xffFCF7F8),
            hasIcon: false,
          ),
        ],
      ),
    );
  }
}
