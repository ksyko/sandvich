import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sandvich/model/artwork.dart';
import 'package:sandvich/widget/connection_lost.dart';
import 'package:sandvich/widget/post.dart';

class ArtworkApp extends StatefulWidget {
  static String route = '/artworks';
  static String title = 'Artworks';

  @override
  State<StatefulWidget> createState() {
    return _ArtworkState();
  }
}

class _ArtworkState extends State<ArtworkApp> {
  Future<List<Artwork>> futureFeed;

  @override
  void initState() {
    super.initState();
    futureFeed = fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ArtworkApp.title),
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
        child: FutureBuilder<List<Artwork>>(
          future: futureFeed,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return listView(snapshot.data);
            else if (snapshot.hasError) return ConnectionLost();
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Widget listView(List<Artwork> items) {
  return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        Artwork artwork = items[index];
        return Post(
          artwork.title,
          artwork.artwork,
          artwork.artwork,
          artwork.authorUrl,
          artwork.author,
        );
      });
}

List<Artwork> parseArtwork(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Artwork>((json) => Artwork.fromJson(json)).toList();
}

Future<List<Artwork>> fetchFeed() async {
  final response = await http.get('https://ksyko.duckdns.org/aw.json');

  if (response.statusCode == 200) {
    return compute(parseArtwork, response.body);
  } else {
    throw Exception('Failed to load feed');
  }
}
