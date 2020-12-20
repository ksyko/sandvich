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
  EdgeInsets edgeInsets;
  return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        bool title = ('${items[index].title}' != '');
        HtmlWidget newsContent = HtmlWidget(
          '${items[index].description}'.replaceAll('<br><br>', ''),
          onTapUrl: (url) => Util().launchURL(url),
          enableCaching: true,
        );
        if (title)
          edgeInsets = const EdgeInsets.fromLTRB(8.0, 8, 0, 4);
        else
          edgeInsets = const EdgeInsets.fromLTRB(8.0, 16, 0, 4);
        return Post(
          items[index].title,
          items[index].link,
          Padding(
            padding: const EdgeInsets.all(16),
            child: newsContent,
          ),
          items[index].link,
          items[index].source,
          items[index].sourceThumbnail,
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
