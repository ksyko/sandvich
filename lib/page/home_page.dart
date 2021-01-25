import 'package:flutter/material.dart';
import 'package:sandvich/page/artwork_page.dart';
import 'package:sandvich/page/calculator_page.dart';
import 'package:sandvich/page/item_search_page.dart';
import 'package:sandvich/page/news_page.dart';
import 'package:sandvich/page/stats_page.dart';
import 'package:sandvich/page/user_page.dart';
import 'package:sandvich/page/video_page.dart';
import 'package:sandvich/widget/content_tile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sandvich'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'About',
            onPressed: () {
              showAboutDialog(
                applicationName: "Sandvich",
                context: context,
                applicationLegalese: "'Sandvich make me strong' \n"
                    "But what makes sandvich strong\n"
                    "These wonderful libraries...",
              );
            },
          ),
        ],
      ),
      body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: false,
          childAspectRatio: 1.5,
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
            contentTile(context, ItemSearchPage.route, ItemSearchPage.title,
                Icons.auto_awesome),
            contentTile(context, CalculatorApp.route, CalculatorApp.title,
                Icons.calculate_rounded),
          ]),
    );
  }
}
