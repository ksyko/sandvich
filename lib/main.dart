import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sandvich/page/artwork_page.dart';
import 'package:sandvich/page/calculator_page.dart';
import 'package:sandvich/page/home_page.dart';
import 'package:sandvich/page/item_search_page.dart';
import 'package:sandvich/page/news_page.dart';
import 'package:sandvich/page/stats_page.dart';
import 'package:sandvich/page/steam_id_page.dart';
import 'package:sandvich/page/user_page.dart';
import 'package:sandvich/page/video_page.dart';
import 'package:sandvich/widget/connection_lost.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  runApp(SandvichApp());
}

class SandvichApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme,
        ),
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
        ItemSearchPage.route: (context) => ItemSearchPage(),
      },
      title: 'Sandvich',
      builder: (BuildContext context, Widget widget) {
        Widget error = StatusIndicator(Status.Error);
        if (widget is Scaffold || widget is Navigator)
          error = Scaffold(body: Center(child: error));
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;
        return widget;
      },
    );
  }
}
