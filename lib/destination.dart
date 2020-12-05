import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon);

  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Artwork', Icons.brush_rounded),
  Destination('News', Icons.library_books_rounded),
  Destination('Video', Icons.video_library_rounded),
];
