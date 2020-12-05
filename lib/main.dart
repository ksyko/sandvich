import 'package:flutter/material.dart';
import 'package:sandvich/page/home_page.dart';

void main() {
  runApp(SandvichApp());
}

//https://coolors.co/644536-b2675e-c4a381-bbd686-eef1bd
class SandvichApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sandvich',
      theme: ThemeData(
        primaryColor: Color(0xFF6A8D73),
        scaffoldBackgroundColor: Color(0xFFE4FFE1),
        cardColor: Color(0xFFF4FDD9),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF6A8D73),
          selectedItemColor: Color(0xFFE4FFE1),
        ),
      ),
      home: HomePage(),
    );
  }
}
