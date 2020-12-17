import 'dart:ui';

import 'package:flutter/material.dart';

enum Status {
  ConnectionLost,
  Loading,
  Error,
}

class StatusIndicator extends StatelessWidget {
  final reason;

  StatusIndicator(this.reason);

  @override
  Widget build(BuildContext context) {
    String image;
    String message;
    if (reason == Status.Loading) {
      image = 'images/archimedes.png';
      message = 'Loading...';
    } else if (reason == Status.ConnectionLost) {
      image = 'images/gibus.png';
      message = 'Please check your internet connection and refresh the page';
    } else if (reason == Status.Error) {
      image = 'images/bread.png';
      message = 'Something went wrong. Please try again later.';
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 80,
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
            child: Text(
              message,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
