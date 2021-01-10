import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sandvich/page/steam_id_page.dart';
import 'package:sandvich/widget/connection_lost.dart';
import 'package:sandvich/widget/info_card.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

Box savedData;

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
    String query;
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
                  InfoCard(
                    null,
                    "Enter Steam ID",
                    "Enter your Steam ID or Steam profile URL to get account links for various sites",
                    () => Toast.show("Enter id/url below", context),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Card(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: TextField(
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(fontSize: 16),
                              onChanged: (text) => {query = text},
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () async {
                                var transform = await fetchSteamId(query);
                                if (transform.success) {
                                  savedData.put('steam_id', transform.steamId);
                                  Toast.show(
                                    "Steam id saved",
                                    context,
                                    duration: 2,
                                  );
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, UserApp.route);
                                } else
                                  Toast.show(
                                    transform.message,
                                    context,
                                    duration: 2,
                                  );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return links(snapshot.data, context);
            }
          } else if (snapshot.hasError) StatusIndicator(Status.Error);
          return StatusIndicator(Status.Loading);
        },
      ),
    );
  }
}

SingleChildScrollView links(String steamId, BuildContext context) {
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
        InfoCard(
          Icons.cancel_rounded,
          "delete steam id",
          "",
          () => {
            savedData.put("steam_id", ""),
            Navigator.pop(context),
          },
        ),
      ],
    ),
  );
}

Future<String> getUserSteamId() async {
  savedData = await Hive.openBox('saved');
  String steamId = savedData.get('steam_id', defaultValue: "");
  return steamId;
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
