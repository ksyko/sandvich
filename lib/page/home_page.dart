import 'package:flutter/material.dart';
import 'package:sandvich/page/artwork_page.dart';
import 'package:sandvich/page/news_page.dart';
import 'package:sandvich/page/stats_page.dart';
import 'package:sandvich/page/user_page.dart';
import 'package:sandvich/page/video_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sandvich'),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          childAspectRatio: 2,
          children: [
            contentTile(context, ArtworkApp.route, ArtworkApp.title,
                Icons.brush_rounded),
            contentTile(context, VideoApp.route, VideoApp.title,
                Icons.video_collection_rounded),
            contentTile(context, NewsApp.route, NewsApp.title,
                Icons.library_books_rounded),
            contentTile(context, StatsApp.route, StatsApp.title,
                Icons.bar_chart_rounded),
            contentTile(context, UserApp.route, UserApp.title, Icons.person),
          ]),
    );
  }

  Card contentTile(
      BuildContext context, String route, String title, IconData icon) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 16,
            ),
            Icon(
              icon,
              size: 36,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
