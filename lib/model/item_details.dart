class ItemDetails {
  Schema schema;

  ItemDetails({this.schema});

  ItemDetails.fromJson(dynamic json) {
    schema = json["schema"] != null ? Schema.fromJson(json["schema"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (schema != null) {
      map["schema"] = schema.toJson();
    }
    return map;
  }
}

class Schema {
  String itemName;
  String imageUrl;
  String imageUrlLarge;
  String itemSlot;
  List<String> usedByClasses;

  Schema(
      {this.itemName,
      this.imageUrl,
      this.imageUrlLarge,
      this.itemSlot,
      this.usedByClasses});

  Schema.fromJson(dynamic json) {
    itemName = json["item_name"];
    imageUrl = json["image_url"];
    imageUrlLarge = json["image_url_large"];
    itemSlot = json["item_slot"];
    usedByClasses = json["used_by_classes"] != null
        ? json["used_by_classes"].cast<String>()
        : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["item_name"] = itemName;
    map["image_url"] = imageUrl;
    map["image_url_large"] = imageUrlLarge;
    map["item_slot"] = itemSlot;
    map["used_by_classes"] = usedByClasses;
    return map;
  }
}
