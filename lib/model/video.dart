import 'package:time_formatter/time_formatter.dart';

class Video {
  final String url;
  final String source;
  final String title;
  final String thumbnail;
  final String timestamp;

  Video({this.url, this.source, this.title, this.thumbnail, this.timestamp});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      url: 'https://www.youtube.com/watch?v=${json['_id']}',
      source: json['source'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      timestamp: formatTime(json['timestamp'] * 1000),
    );
  }
}
