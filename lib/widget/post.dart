import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sandvich/dimens/dimens.dart';
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
  final String authorUrl;

  Post(
    this.title,
    this.contentUrl,
    this.content,
    this.shareUrl,
    this.author,
    this.authorImageUrl,
    this.authorUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                GestureDetector(
                  child: UserThumbnail(authorImageUrl),
                  onTap: () => Util().launchURL(authorUrl),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title.isNotEmpty)
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: Dimens.subtitle1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      GestureDetector(
                        onTap: () {
                          Util().launchURL(authorUrl);
                        },
                        child: Text(
                          author,
                          textAlign: TextAlign.start,
                          style: Dimens.caption,
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
      ),
    );
  }
}
