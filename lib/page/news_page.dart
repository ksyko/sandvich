import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:sandvich/model/news.dart';
import 'package:sandvich/util.dart';
import 'package:sandvich/widget/connection_lost.dart';
import 'package:time_formatter/time_formatter.dart';

class NewsApp extends StatefulWidget {
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
        title: Text('News'),
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
        child: FutureBuilder<List<News>>(
          future: futureFeed,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              lastId = snapshot.data[0].id;
              return listView(snapshot.data);
            } else if (snapshot.hasError) return ConnectionLost();
            return CircularProgressIndicator();
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
        bool title = ('${items[index].title}' != '');
        return Card(
            elevation: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 16, 0, 0),
                    child: Text(
                      '${items[index].title}',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                if (title)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 4),
                    child: Text(
                      '${(items[index].source)} · ${formatTime(items[index].timestamp * 1000)}',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black38),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 16, 0, 4),
                    child: Text(
                      '${(items[index].source)} · ${formatTime(items[index].timestamp * 1000)}',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 4, 4, 16),
                  child: HtmlWidget(
                    '${items[index].description}'.replaceAll('<br><br>', ''),
                    onTapUrl: (url) => Util().launchURL(url),
                  ),
                ),
              ],
            ));
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
