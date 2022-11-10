import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:splitit/backend/account.dart';
import 'package:splitit/frontend/welcome/welcome.dart';
import 'package:splitit/global.dart';

import '../../../size.dart';
import '../../components/custom_page_route.dart';

class AccountBody extends StatefulWidget {
  const AccountBody(
      {super.key,
      required this.name,
      required this.email,
      required this.photo,
      required this.theme,
      required this.changeTheme,
      required this.changeTab});
  final String name, email, photo, theme;
  final Function changeTheme, changeTab;

  @override
  State<AccountBody> createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  List<String> themes = ["Light", "Dark", "Auto"];
  late String theme, version;
  final window = WidgetsBinding.instance.window;
  bool isVersionReady = false;

  @override
  void initState() {
    theme = widget.theme;
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        version = packageInfo.version;
        isVersionReady = true;
      });
    });

    super.initState();
  }

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
              Text(
                "My Account",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getHeight(40)),
              Hero(
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
                      Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              OptionCard(
                                title: "My Wallet",
                                iconPath: "assets/icons/wallet.svg",
                                onClicked: () => widget.changeTab(2),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getHeight(25)),
                                child: DottedLine(
                                  dashColor: Theme.of(context)
                                      .primaryColorDark
                                      .withOpacity(0.2),
                                  lineThickness: 2,
                                  dashRadius: 2,
                                  dashLength: 6,
                                  dashGapLength: 6,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(getHeight(25)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/theme.svg",
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        SizedBox(width: getHeight(10)),
                                        Text(
                                          "Theme",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            fontSize: getHeight(16),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                      iconEnabledColor:
                                          Theme.of(context).primaryColorDark,
                                      buttonDecoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      dropdownDecoration: BoxDecoration(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      icon: const FaIcon(
                                          Icons.arrow_drop_down_rounded),
                                      iconSize: getHeight(20),
                                      onChanged: (value) {
                                        setState(() {
                                          theme = value!;
                                          widget.changeTheme(theme);
                                          themeChanger.changeThemeMode(theme);
                                          themeChanger.isDarkMode = themeChanger
                                                      .currentTheme() ==
                                                  ThemeMode.system
                                              ? WidgetsBinding.instance.window
                                                      .platformBrightness ==
                                                  Brightness.dark
                                              : themeChanger.currentTheme() ==
                                                  ThemeMode.dark;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getHeight(25)),
                                child: DottedLine(
                                  dashColor: Theme.of(context)
                                      .primaryColorDark
                                      .withOpacity(0.2),
                                  lineThickness: 2,
                                  dashRadius: 2,
                                  dashLength: 6,
                                  dashGapLength: 6,
                                ),
                              ),
                              OptionCard(
                                title: "Invite People",
                                iconPath: "assets/icons/invite.svg",
                                onClicked: () {
                                  Share.share(
                                      "Check out this new app, Split-It! Now you can split your bills among friends, download the app using this link: https://drive.google.com/drive/folders/1F2kGvGIdpgGxSna5V6R_WtegFi_GRFEE?usp=sharing");
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getHeight(25)),
                                child: DottedLine(
                                  dashColor: Theme.of(context)
                                      .primaryColorDark
                                      .withOpacity(0.2),
                                  lineThickness: 2,
                                  dashRadius: 2,
                                  dashLength: 6,
                                  dashGapLength: 6,
                                ),
                              ),
                              OptionCard(
                                title: "Logout",
                                iconPath: "assets/icons/logout.svg",
                                onClicked: () {
                                  Account.googleLogout();
                                  Navigator.pushReplacement(
                                    context,
                                    CustomPageRoute(
                                      context,
                                      const Welcome(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (isVersionReady)
                        Text(
                          "v $version",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: getHeight(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isVersionReady)
                        SizedBox(
                          width: getHeight(20),
                          height: getHeight(20),
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColorDark,
                            strokeWidth: 2,
                          ),
                        ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.onClicked,
  }) : super(key: key);
  final String iconPath, title;
  final GestureTapCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
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
    );
  }
}
