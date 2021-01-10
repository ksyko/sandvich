class PricesLinks {
  bool success;
  String sku;
  String name;
  Links links;

  PricesLinks({this.success, this.sku, this.name, this.links});

  PricesLinks.fromJson(dynamic json) {
    success = json["success"];
    sku = json["sku"];
    name = json["name"];
    links = json["links"] != null ? Links.fromJson(json["links"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["sku"] = sku;
    map["name"] = name;
    if (links != null) {
      map["links"] = links.toJson();
    }
    return map;
  }
}

class Links {
  String ptf;
  String mptf;
  String scm;
  String bptf;

  Links({this.ptf, this.mptf, this.scm, this.bptf});

  Links.fromJson(dynamic json) {
    ptf = json["ptf"];
    mptf = json["mptf"];
    scm = json["scm"];
    bptf = json["bptf"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ptf"] = ptf;
    map["mptf"] = mptf;
    map["scm"] = scm;
    map["bptf"] = bptf;
    return map;
  }
}
