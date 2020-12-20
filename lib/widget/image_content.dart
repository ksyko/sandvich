import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageContent extends StatelessWidget {
  final String imageUrl;

  ImageContent(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fitWidth,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
