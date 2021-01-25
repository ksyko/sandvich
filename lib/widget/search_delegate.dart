import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sandvich/api/search_service.dart';
import 'package:sandvich/model/item_search_result.dart';
import 'package:sandvich/page/item_page.dart';
import 'package:sandvich/widget/connection_lost.dart';

class ItemSearchDelegate extends SearchDelegate {
  ItemSearchDelegate(this.searchService);

  final SearchService searchService;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Search term must be longer than two letters.",
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      );
    } else {
      try {
        searchService.searchItem(query);
        return StreamBuilder<List<ItemSearchResult>>(
          stream: searchService.results,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return ListTile(
                  leading: Icon(Icons.close),
                  title: Text("No such item found"),
                );
              } else if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.circle),
                      title: Text(snapshot.data[index].name),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemPage(
                              itemPrice: snapshot.data[index],
                            ),
                          ),
                        )
                      },
                    );
                  },
                );
              } else {
                return StatusIndicator(Status.Loading);
              }
            } else {
              return StatusIndicator(Status.Loading);
            }
          },
        );
      } catch (e) {
        return StatusIndicator(Status.Error);
      }
    }
  }
}
