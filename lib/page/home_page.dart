import 'package:flutter/material.dart';
import 'package:sandvich/page/artwork_page.dart';
import 'package:sandvich/page/news_page.dart';
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
          padding: const EdgeInsets.all(16.0),
          children: [
            contentTile(context, ArtworkApp.route, ArtworkApp.title,
                Icons.brush_rounded),
            contentTile(context, VideoApp.route, VideoApp.title,
                Icons.video_collection_rounded),
            contentTile(context, NewsApp.route, NewsApp.title,
                Icons.library_books_rounded),
          ]),
    );
  }

  InkWell contentTile(
      BuildContext context, String route, String title, IconData icon) {
    return InkWell(
      onTap: () => Navigator.pushReplacementNamed(context, route),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
