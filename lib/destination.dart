import 'package:flutter/material.dart';
import 'package:sandvich/page/artwork_page.dart';

class Destination {
  Destination(this.title, this.route, this.icon);

  final String title;
  final String route;
  final IconData icon;
}

final List<Destination> allDestinations = <Destination>[
  Destination('Artworks', ArtworkApp.route, Icons.brush_rounded),
  Destination('News', ArtworkApp.route, Icons.library_books_rounded),
  Destination('Videos', ArtworkApp.route, Icons.video_library_rounded),
];
