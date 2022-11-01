import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  late SharedPreferences pref;
  bool prefIsReady = false;

  @override
  void initState() {
    sharedPreferences.then((value) {
      pref = value;
      setState(() {
        prefIsReady = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Row(
          children: [
            if (prefIsReady)
              Column(
                children: [
                  // Container(
                  //   decoration: BoxDecoration(),
                  // )
                  Image.network(pref.getString("photo")!,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )),
                  Text(pref.getString("name")!),
                  Text(pref.getString("email")!),
                ],
              ),
            if (!prefIsReady)
              CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
          ],
        )
      ],
    ));
  }
}
