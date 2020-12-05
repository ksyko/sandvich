import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../util.dart';

class Post extends StatelessWidget {
  final String title;
  final String content;
  final String thumbnail;
  final String shareUrl;
  final String author;

  Post(
    this.title,
    this.content,
    this.thumbnail,
    this.shareUrl,
    this.author,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 0),
            child: Row(children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: GestureDetector(
                  onTap: () {
                    Share.share(content);
                  },
                  child: Icon(
                    Icons.share,
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4, 0, 4),
            child: GestureDetector(
              onTap: () {
                Util().launchURL(shareUrl);
              },
              child: Text(
                author,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black38, fontSize: 12),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Util().launchURL(content);
            },
            child: CachedNetworkImage(
              imageUrl: thumbnail,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}
