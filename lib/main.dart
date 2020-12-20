import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sandvich/page/artwork_page.dart';
import 'package:sandvich/page/calculator_page.dart';
import 'package:sandvich/page/home_page.dart';
import 'package:sandvich/page/news_page.dart';
import 'package:sandvich/page/stats_page.dart';
import 'package:sandvich/page/steam_id_page.dart';
import 'package:sandvich/page/user_page.dart';
import 'package:sandvich/page/video_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  runApp(SandvichApp());
}

class SandvichApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sandvich',
      theme: ThemeData(
        primaryColor: Color(0xFF171515),
        scaffoldBackgroundColor: Color(0xFF6f5b3e),
        cardColor: Color(0xFFc4ae78),
        splashColor: Color(0xFF6f5b3e),
        buttonColor: Color(0xFF171515),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xFF171515),
          selectionHandleColor: Color(0xFF171515),
        ),
        fontFamily: 'Baloo2',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        ArtworkApp.route: (context) => ArtworkApp(),
        NewsApp.route: (context) => NewsApp(),
        VideoApp.route: (context) => VideoApp(),
        StatsApp.route: (context) => StatsApp(),
        UserApp.route: (context) => UserApp(),
        SteamIdApp.route: (context) => SteamIdApp(),
        CalculatorApp.route: (context) => CalculatorApp(),
      },
    );
  }
}
