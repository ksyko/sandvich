import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sandvich/dimens/colors.dart';
import 'package:sandvich/dimens/dimens.dart';
import 'package:sandvich/model/item_details.dart';
import 'package:sandvich/model/item_search_result.dart';
import 'package:sandvich/model/prices_links.dart';
import 'package:sandvich/util.dart';
import 'package:sandvich/widget/connection_lost.dart';

class ItemPage extends StatelessWidget {
  final ItemSearchResult itemPrice;

  @override
  Widget build(BuildContext context) {
    Future<ItemDetails> itemDetails;
    Future<PricesLinks> priceLinks;
    itemDetails = getItemResults(itemPrice.sku);
    priceLinks = getLinks(itemPrice.sku);
    return Scaffold(
      appBar: AppBar(
        title: Text("Item page"),
      ),
      body: Center(
        child: FutureBuilder<ItemDetails>(
            future: itemDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  Schema schema = snapshot.data.schema;
                  return Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    child: CachedNetworkImage(
                                      imageUrl: schema.imageUrlLarge
                                          .replaceFirst('http://', 'https://'),
                                    ),
                                    backgroundColor: Colors.blueGrey,
                                    radius: double.infinity,
                                  ),
                                ),
                              ), // image
                              Flexible(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Flexible(
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 16, 0, 16),
                                          child: Text(
                                            "Sellers at:\n${itemPrice.sell.keys.toInt()} keys ${itemPrice.sell.metal.toInt()} ref",
                                            style: Dimens.bodyText2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 16, 0, 16),
                                          child: Text(
                                            "Buyers at:\n${itemPrice.buy.keys.toInt()} keys ${itemPrice.buy.metal.toInt()} ref",
                                            style: Dimens.bodyText2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ), // column - orders
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            itemPrice.name,
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            style: Dimens.headline6,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Flexible(
                        child: FutureBuilder<PricesLinks>(
                          future: priceLinks,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null) {
                                Links links = snapshot.data.links;
                                return ListView(
                                  padding: EdgeInsets.all(16),
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    RoundIcon(
                                      "BPTF",
                                      Kolors.backpack,
                                      links.bptf,
                                    ),
                                    RoundIcon(
                                      "MPTF",
                                      Kolors.marketplace,
                                      links.mptf,
                                    ),
                                    RoundIcon(
                                      "SCM",
                                      Kolors.steam,
                                      links.scm,
                                    ),
                                    RoundIcon(
                                      "PTF",
                                      Kolors.prices,
                                      links.ptf,
                                    ),
                                    RoundIcon("WIKI", Kolors.wiki,
                                        "https://wiki.teamfortress.com/wiki/${schema.itemName}"),
                                  ],
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            } else if (snapshot.hasError)
                              return StatusIndicator(Status.Error);
                            return StatusIndicator(Status.Loading);
                          },
                        ),
                      )
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              } else if (snapshot.hasError)
                return StatusIndicator(Status.Error);
              return StatusIndicator(Status.Loading);
            }),
      ),
    );
  }

  ItemPage({Key key, this.itemPrice}) : super(key: key);
}

class RoundIcon extends StatelessWidget {
  final String text;
  final Color color;
  final String link;

  RoundIcon(this.text, this.color, this.link);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
      ),
      child: RaisedButton(
        onPressed: () {
          Util().launchURL(link);
        },
        child: Text(text),
        textColor: Colors.white,
        color: color,
      ),
    );
  }
}

ItemDetails parseItemResults(String responseBody) {
  final parsed = json.decode(responseBody);
  return ItemDetails.fromJson(parsed);
}

Future<ItemDetails> getItemResults(String sku) async {
  var safeQuery = Uri.encodeComponent(sku);
  var response = await http
      .get('https://ksyko.duckdns.org:5000/tf/item/v1?sku=$safeQuery');

  if (response.statusCode == 200) {
    return compute(parseItemResults, response.body);
  } else {
    throw Exception('Failed to load feed');
  }
}

PricesLinks parseLinks(String responseBody) {
  final parsed = json.decode(responseBody);
  return PricesLinks.fromJson(parsed);
}

Future<PricesLinks> getLinks(String sku) async {
  var safeQuery = Uri.encodeComponent(sku);
  var response = await http.get('https://api.prices.tf/items/$safeQuery/links');

  if (response.statusCode == 200) {
    return compute(parseLinks, response.body);
  } else {
    throw Exception('Failed to load feed');
  }
}

void test() {}
