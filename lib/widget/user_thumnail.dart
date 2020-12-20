import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserThumbnail extends StatelessWidget {
  final String url;

  UserThumbnail(this.url);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
