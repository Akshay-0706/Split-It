import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitit/global.dart';
import 'package:splitit/theme.dart';

import '../../size.dart';

class AccountBody extends StatefulWidget {
  const AccountBody(
      {super.key,
      required this.name,
      required this.email,
      required this.photo,
      required this.theme,
      required this.changeTheme});
  final String name, email, photo, theme;
  final Function changeTheme;

  @override
  State<AccountBody> createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  List<String> themes = ["Light", "Dark", "Auto"];
  late String theme;
  final window = WidgetsBinding.instance.window;

  @override
  void initState() {
    theme = widget.theme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getHeight(40)),
          Text(
            "My Account",
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getHeight(20),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: getHeight(40)),
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
                imageUrl: widget.photo,
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
            widget.name,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getHeight(22),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.email,
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontSize: getHeight(16),
            ),
          ),
          SizedBox(height: getHeight(40)),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark.withOpacity(0.05),
              ),
              child: Column(
                children: [
                  const OptionCard(
                    title: "My Wallet",
                    iconPath: "assets/icons/wallet.svg",
                  ),
                  Padding(
                    padding: EdgeInsets.all(getHeight(20)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/home.svg",
                          color: Theme.of(context).primaryColorDark,
                        ),
                        SizedBox(width: getHeight(10)),
                        Text(
                          "Theme",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: getHeight(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        CustomDropdownButton2(
                          hint: theme,
                          value: theme,
                          hintAlignment: Alignment.center,
                          valueAlignment: Alignment.center,
                          buttonWidth: getHeight(100),
                          buttonPadding: EdgeInsets.zero,
                          buttonHeight: getHeight(25),
                          dropdownWidth: getHeight(100),
                          dropdownItems: themes,
                          iconEnabledColor: Theme.of(context).primaryColorDark,
                          buttonDecoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          dropdownDecoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          icon: const FaIcon(Icons.arrow_drop_down_rounded),
                          iconSize: getHeight(20),
                          onChanged: (value) {
                            setState(() {
                              theme = value!;
                              themeChanger.changeThemeMode(theme);
                              widget.changeTheme(theme);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
                    child: DottedLine(
                      dashColor:
                          Theme.of(context).primaryColorDark.withOpacity(0.2),
                      lineThickness: 2,
                      dashRadius: 2,
                      dashLength: 6,
                      dashGapLength: 6,
                    ),
                  ),
                  const OptionCard(
                    title: "Invite People",
                    iconPath: "assets/icons/wallet.svg",
                  ),
                  const OptionCard(
                    title: "Logout",
                    iconPath: "assets/icons/wallet.svg",
                  ),
                  const Spacer(),
                  Text(
                    "v 1.0",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: getHeight(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    required this.iconPath,
    required this.title,
  }) : super(key: key);
  final String iconPath, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(getHeight(25)),
            child: Ink(
              child: Row(
                children: [
                  SvgPicture.asset(
                    iconPath,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  SizedBox(width: getHeight(10)),
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: getHeight(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: getHeight(20),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getHeight(25)),
          child: DottedLine(
            dashColor: Theme.of(context).primaryColorDark.withOpacity(0.2),
            lineThickness: 2,
            dashRadius: 2,
            dashLength: 6,
            dashGapLength: 6,
          ),
        ),
      ],
    );
  }
}
