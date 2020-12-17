import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sandvich/model/stats.dart';
import 'package:sandvich/widget/connection_lost.dart';
import 'package:sandvich/widget/info_card.dart';
import 'package:time_formatter/time_formatter.dart';

class StatsApp extends StatefulWidget {
  static String route = '/stats';
  static String title = 'Stats';

  @override
  State<StatefulWidget> createState() {
    return _StatsState();
  }
}

class _StatsState extends State<StatsApp> {
  Future<Stats> futureFeed;
  String lastId;

  @override
  void initState() {
    super.initState();
    futureFeed = fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StatsApp.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              setState(() {
                futureFeed = fetchFeed();
              });
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<Stats>(
          future: futureFeed,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    InfoCard(
                      Icons.api_rounded,
                      "Game coordinator",
                      snapshot.data.gcStatus,
                    ),
                    InfoCard(
                      Icons.access_time_rounded,
                      "Last game update",
                      formatTime(int.parse(snapshot.data.tfLastUpdate) * 1000),
                    ),
                    InfoCard(
                      Icons.group_rounded,
                      "People playing",
                      "${snapshot.data.tfPlayers}  ( ${formatTime(int.parse(snapshot.data.tfChartsUpdateTimestamp) * 1000).toString()} )",
                    ),
                    InfoCard(
                      Icons.vpn_key_rounded,
                      "Key prices",
                      "${snapshot.data.bptfKeyPrice} ( bptf )\n${snapshot.data.mptfKeyPrice} ( mptf )\n${snapshot.data.scmKeyPrice} ( scm )",
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) StatusIndicator(Status.Error);
            return StatusIndicator(Status.Loading);
          },
        ),
      ),
    );
  }
}

Stats parseStats(String responseBody) {
  final parsed = json.decode(responseBody);
  return Stats.fromJson(parsed);
}

Future<Stats> fetchFeed() async {
  final response = await http.get('https://ksyko.duckdns.org/stats.json');
  if (response.statusCode == 200) {
    return compute(parseStats, response.body);
  } else {
    throw Exception('Failed to load feed');
  }
}
