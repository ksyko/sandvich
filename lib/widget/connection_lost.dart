import 'dart:ui';

import 'package:flutter/material.dart';

class ConnectionLost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/gibus.png',
            width: 80,
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
            child: Text(
              'Please check your internet connection and refresh the page',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
