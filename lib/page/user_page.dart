import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sandvich/page/steam_id_page.dart';
import 'package:sandvich/widget/connection_lost.dart';
import 'package:sandvich/widget/info_card.dart';
import 'package:url_launcher/url_launcher.dart';

class UserApp extends StatefulWidget {
  static String route = '/User';
  static String title = 'Accounts';

  @override
  State<StatefulWidget> createState() {
    return _UserState();
  }
}

class _UserState extends State<UserApp> {
  Future<String> steamId;

  @override
  void initState() {
    super.initState();
    steamId = getUserSteamId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UserApp.title),
      ),
      body: FutureBuilder<String>(
        future: steamId,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return Column(
                children: [
                  Text(
                      "This page provides quick access to all your tf profiles."
                      "\nPlease provide you steam id"),
                  ElevatedButton(
                    child: Text("Enter steam id"),
                    onPressed: () =>
                        Navigator.pushNamed(context, SteamIdApp.route),
                  )
                ],
              );
            } else {
              return links(snapshot.data);
            }
          } else if (snapshot.hasError) StatusIndicator(Status.Error);
          return StatusIndicator(Status.Loading);
        },
      ),
    );
  }
}

SingleChildScrollView links(String steamId) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InfoCard(
          Icons.backpack_rounded,
          "backpack",
          "",
          () => _launchURL("https://backpack.tf/profiles/$steamId"),
        ),
        InfoCard(
          Icons.add_chart,
          "logs",
          "",
          () => _launchURL("https://logs.tf/profile/$steamId"),
        ),
        InfoCard(
          Icons.stacked_line_chart,
          "stn",
          "",
          () => _launchURL("https://stntrading.eu/profiles/$steamId"),
        ),
        InfoCard(
          Icons.compare_arrows_rounded,
          "bazaar",
          "",
          () => _launchURL("https://bazaar.tf/profiles/$steamId"),
        ),
        InfoCard(
          Icons.web,
          "steam",
          "",
          () => _launchURL("https://steamcommunity.com/profiles/$steamId"),
        ),
      ],
    ),
  );
}

Future<String> getUserSteamId() async {
  var prefsBox = await Hive.openBox('prefs');
  String steamId = prefsBox.get('steam_id', defaultValue: "");
  return steamId;
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
