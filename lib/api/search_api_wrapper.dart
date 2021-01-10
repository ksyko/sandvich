import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sandvich/model/item_search_result.dart';

class SearchAPIWrapper {
  Future<List<ItemSearchResult>> getItemResults(String query) async {
    var safeQuery = Uri.encodeComponent(query);
    var response = await http.get(
        'https://ksyko.duckdns.org:5000/tf/search/v1?item=$safeQuery&orders=true');
    if (response.statusCode == 200) {
      return compute(parseItemResults, response.body);
    } else {
      throw Exception('Failed to load feed');
    }
  }
}

List<ItemSearchResult> parseItemResults(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<ItemSearchResult>((json) => ItemSearchResult.fromJson(json))
      .toList();
}
