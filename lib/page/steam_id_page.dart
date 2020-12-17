import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:sandvich/model/transform.dart' as Rep;
import 'package:toast/toast.dart';

Box prefsBox;

class SteamIdApp extends StatefulWidget {
  static String route = '/SteamId';
  static String title = 'SteamId';

  @override
  State<StatefulWidget> createState() {
    return _SteamIdState();
  }
}

class _SteamIdState extends State<SteamIdApp> {
  Future<String> steamId;
  String query;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: openPrefs(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasError)
            return Scaffold(
              appBar: AppBar(
                title: Text(SteamIdApp.title),
              ),
              body: Center(
                  child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'SteamID / Steam profile URL',
                    ),
                    onChanged: (text) => {query = text},
                  ),
                  ElevatedButton(
                    child: Text("Search"),
                    onPressed: () async {
                      var transform = await fetchSteamId(query);
                      if (transform.success) {
                        prefsBox.put('steam_id', transform.steamId);
                        Toast.show("Steam id saved", context, duration: 2);
                        Navigator.pop(context);
                      } else
                        Toast.show(transform.message, context, duration: 2);
                    },
                  )
                ],
              )),
            );
          else
            return Text("");
        });
  }
}

Future<bool> openPrefs() async {
  prefsBox = await Hive.openBox('prefs');
  return true;
}

Rep.Transform parseTransform(String responseBody) {
  final parsed = json.decode(responseBody);
  return Rep.Transform.fromJson(parsed);
}

Future<Rep.Transform> fetchSteamId(String query) async {
  final response = await http.get('https://rep.tf/api/transform?str=$query');
  if (response.statusCode == 200) {
    return compute(parseTransform, response.body);
  } else {
    throw Exception('Failed to load feed');
  }
}
