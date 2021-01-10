import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sandvich/model/video.dart';
import 'package:sandvich/widget/connection_lost.dart';
import 'package:sandvich/widget/image_content.dart';
import 'package:sandvich/widget/post.dart';

class VideoApp extends StatefulWidget {
  static String route = '/videos';
  static String title = 'Videos';

  @override
  State<StatefulWidget> createState() {
    return _VideoState();
  }
}

class _VideoState extends State<VideoApp> {
  Future<List<Video>> futureFeed;

  @override
  void initState() {
    super.initState();
    if (futureFeed == null) futureFeed = fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(VideoApp.title), actions: [
        IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              setState(() {
                futureFeed = fetchFeed();
              });
            }),
      ]),
      body: Center(
        child: FutureBuilder<List<Video>>(
          future: futureFeed,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return listView(snapshot.data);
            else if (snapshot.hasError) StatusIndicator(Status.Error);
            return StatusIndicator(Status.Loading);
          },
        ),
      ),
    );
  }
}

Widget listView(List<Video> items) {
  return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        Video video = items[index];
        return Post(
          video.title,
          video.url,
          ImageContent(video.thumbnail),
          video.url,
          '${video.source} · ${video.timestamp}',
          video.authorThumbnail,
          video.url,
        );
      });
}

List<Video> parseVideo(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Video>((json) => Video.fromJson(json)).toList();
}

Future<List<Video>> fetchFeed() async {
  final response = await http.get('https://ksyko.duckdns.org/yt.json');

  if (response.statusCode == 200) {
    return compute(parseVideo, response.body);
  } else {
    throw Exception('Failed to load feed');
  }
}
