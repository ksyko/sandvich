class ItemSearchResult {
  String name;
  String sku;
  Buy buy;
  Sell sell;

  ItemSearchResult({this.name, this.sku, this.buy, this.sell});

  ItemSearchResult.fromJson(dynamic json) {
    name = json["name"];
    sku = json["sku"];
    buy = json["buy"] != null ? Buy.fromJson(json["buy"]) : null;
    sell = json["sell"] != null ? Sell.fromJson(json["sell"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["sku"] = sku;
    if (buy != null) {
      map["buy"] = buy.toJson();
    }
    if (sell != null) {
      map["sell"] = sell.toJson();
    }
    return map;
  }
}

class Sell {
  double keys;
  double metal;

  Sell({this.keys, this.metal});

  Sell.fromJson(dynamic json) {
    keys = double.parse(json["keys"].toString());
    metal = double.parse(json["metal"].toString());
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["keys"] = keys;
    map["metal"] = metal;
    return map;
  }
}

class Buy {
  double keys;
  double metal;

  Buy({this.keys, this.metal});

  Buy.fromJson(dynamic json) {
    keys = double.parse(json["keys"].toString());
    metal = double.parse(json["metal"].toString());
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["keys"] = keys;
    map["metal"] = metal;
    return map;
  }
}
