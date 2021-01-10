import 'package:flutter/material.dart';
import 'package:sandvich/api/search_api_wrapper.dart';
import 'package:sandvich/api/search_service.dart';
import 'package:sandvich/widget/search_delegate.dart';

class ItemSearchPage extends StatefulWidget {
  static String route = '/item';
  static String title = 'Item Search';

  @override
  _ItemSearchPageState createState() => _ItemSearchPageState();
}

class _ItemSearchPageState extends State<ItemSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ItemSearchPage.title),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () => {
              showSearch(
                context: context,
                delegate: ItemSearchDelegate(
                  SearchService(
                    apiWrapper: SearchAPIWrapper(),
                  ),
                ),
              ),
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          "Search for priced tf2 items\nExamples: 'man key' or 'burn capt'",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
