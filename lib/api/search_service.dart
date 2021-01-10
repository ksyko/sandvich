import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sandvich/api/search_api_wrapper.dart';
import 'package:sandvich/model/item_search_result.dart';

class SearchService {
  Stream<List<ItemSearchResult>> _results;

  Stream<List<ItemSearchResult>> get results => _results;
  final SearchAPIWrapper apiWrapper;

  SearchService({@required this.apiWrapper}) {
    _results = _searchTerms
        .debounce((_) => TimerStream(true, Duration(milliseconds: 500)))
        .switchMap((query) async* {
      print('searching: $query');
      yield await apiWrapper.getItemResults(query);
    }); // discard previous events
  }

  // Input stream (search terms)
  final _searchTerms = BehaviorSubject<String>();

  void searchItem(String query) => _searchTerms.add(query);

  void dispose() {
    _searchTerms.close();
  }
}
