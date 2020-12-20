import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sandvich/widget/user_thumnail.dart';
import 'package:share/share.dart';

import '../util.dart';

class Post extends StatelessWidget {
  final String title;
  final String contentUrl;
  final Widget content;
  final String shareUrl;
  final String author;
  final String authorImageUrl;

  Post(
    this.title,
    this.contentUrl,
    this.content,
    this.shareUrl,
    this.author, [
    this.authorImageUrl,
  ]);

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
              UserThumbnail(authorImageUrl),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title.isNotEmpty)
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    GestureDetector(
                      onTap: () {
                        Util().launchURL(contentUrl);
                      },
                      child: Text(
                        author,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black38, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: GestureDetector(
                  onTap: () {
                    Share.share(contentUrl);
                  },
                  child: Icon(
                    Icons.share,
                  ),
                ),
              ),
            ]),
          ),
          GestureDetector(
            onTap: () {
              Util().launchURL(contentUrl);
            },
            child: content,
          ),
        ],
      ),
    );
  }
}
