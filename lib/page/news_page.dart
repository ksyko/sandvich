import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:sandvich/model/news.dart';
import 'package:sandvich/util.dart';
import 'package:sandvich/widget/connection_lost.dart';
import 'package:sandvich/widget/post.dart';

class NewsApp extends StatefulWidget {
  static String route = '/news';
  static String title = 'News';

  @override
  State<StatefulWidget> createState() {
    return _NewsState();
  }
}

class _NewsState extends State<NewsApp> {
  Future<List<News>> futureFeed;
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
        title: Text(NewsApp.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Sources',
            onPressed: () {
              _showMyDialog(context);
            },
          ),
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
        child: FutureBuilder<List<News>>(
          future: futureFeed,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              lastId = snapshot.data[0].id;
              return listView(snapshot.data);
            } else if (snapshot.hasError) return StatusIndicator(Status.Error);
            return StatusIndicator(Status.Loading);
          },
        ),
      ),
    );
  }
}

Widget listView(List<News> items) {
  return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        HtmlWidget newsContent = HtmlWidget(
          '${items[index].description}'.replaceAll('<br><br>', ''),
          onTapUrl: (url) => Util().launchURL(url),
          enableCaching: true,
        );
        return Post(
          items[index].title,
          items[index].link,
          Padding(
            padding: EdgeInsets.all(16),
            child: newsContent,
          ),
          items[index].link,
          "${items[index].source} · ${items[index].timestamp}",
          items[index].sourceThumbnail,
          items[index].link,
        );
      });
}

List<News> parseNews(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<News>((json) => News.fromJson(json)).toList();
}

Future<List<News>> fetchFeed() async {
  final response = await http.get('https://ksyko.duckdns.org/tf.json');

  if (response.statusCode == 200) {
    return compute(parseNews, response.body);
  } else {
    throw Exception('Failed to load feed');
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  const String url_backpack = "https://twitter.com/backpacktf";
  const String url_creators = "https://twitter.com/creatorstf";
  const String url_kritzkast = "https://www.kritzkast.com/";
  const String url_tf2 = "https://www.teamfortress.com/";
  const String url_tf2maps = "https://twitter.com/tf2maps";
  const String url_toth = "https://twitter.com/tipofthehats";
  const String url_tftv = "https://twitter.com/TeamFortressTV";
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('News are aggregated from the following sources:'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("backpack.tf\n$url_backpack\n"),
                onTap: () => {Util().launchURL("$url_backpack")},
              ),
              GestureDetector(
                child: Text("creators.tf\n$url_creators\n"),
                onTap: () => {Util().launchURL("$url_creators")},
              ),
              GestureDetector(
                child: Text("Kritzkast\n$url_kritzkast\n"),
                onTap: () => {Util().launchURL("$url_kritzkast")},
              ),
              GestureDetector(
                child: Text("Team Fortress\n$url_tf2\n"),
                onTap: () => {Util().launchURL("$url_tf2")},
              ),
              GestureDetector(
                child: Text("Tf2 maps\n$url_tf2maps\n"),
                onTap: () => {Util().launchURL("$url_tf2maps")},
              ),
              GestureDetector(
                child: Text("Tip of the hats\n$url_toth\n"),
                onTap: () => {Util().launchURL("$url_toth")},
              ),
              GestureDetector(
                child: Text("Teamfortress.tv\n$url_tftv\n"),
                onTap: () => {Util().launchURL("$url_tftv")},
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
