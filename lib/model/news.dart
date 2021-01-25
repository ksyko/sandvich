import 'package:time_formatter/time_formatter.dart';

class News {
  final String id;
  final String source;
  final String sourceThumbnail;
  final String title;
  final String description;
  final String timestamp;
  final String link;

  News(
      {this.id,
      this.source,
      this.sourceThumbnail,
      this.title,
      this.description,
      this.timestamp,
      this.link});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['_id'],
      source: json['source'],
      sourceThumbnail: json['source_thumbnail'],
      title: json['title'],
      description: json['description'],
      timestamp: formatTime(json['timestamp'] * 1000),
      link: json['link'],
    );
  }
}
