class Artwork {
  final String author;
  final String profileImage;
  final String title;
  final String authorUrl;
  final String artwork;

  Artwork(
      {this.author,
      this.profileImage,
      this.title,
      this.authorUrl,
      this.artwork});

  factory Artwork.fromJson(Map<String, dynamic> json) {
    return Artwork(
      author: json['author'],
      profileImage: json['profile-image'],
      title: json['title'],
      authorUrl: json['author-url'],
      artwork: json['artwork'],
    );
  }
}
