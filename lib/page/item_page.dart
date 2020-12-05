import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:sandvich/model/artwork.dart';
import 'package:sandvich/model/item.dart';

class ItemApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ItemState();
  }
}

class _ItemState extends State<ItemApp> {
  Future<Box> futureFeed;

  @override
  void initState() {
    super.initState();
    futureFeed = fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                setState(() {
                  futureFeed = fetchFeed();
                });
              }),
        ],
      ),
      body: Center(
        child: FutureBuilder<Box>(
          future: futureFeed,
          builder: (context, snapshot) {
            // if (snapshot.hasData)
            //   return listView(snapshot.data.getAt());
            // else if (snapshot.hasError) return ConnectionLost();
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Widget listView(List<Artwork> items) {}

Box parseItems(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Item>((json) => Item().fromJson(json['items']));
}

Future<Box> fetchFeed() async {
  final response = await http.get('https://api.prices.tf/items?src=bptf');

  if (response.statusCode == 200) {
    return compute(parseItems, response.body);
  } else {
    throw Exception('Failed to load feed');
  }
}
