import 'package:flutter/material.dart';
import 'package:sandvich/page/artwork_page.dart';
import 'package:sandvich/page/news_page.dart';
import 'package:sandvich/page/video_page.dart';

import 'destination.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.destination.title) {
      case "News":
        return NewsApp();
      case "Video":
        return VideoApp();
      case "Artwork":
        return ArtworkApp();
      default:
        return ArtworkApp();
    }
  }
}
