import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Item {
  Item({
    this.name,
    this.sku,
    this.buyKeys,
    this.buyMetal,
    this.sellKeys,
    this.sellMetal,
  });

  @HiveField(0)
  int sku;

  @HiveField(1)
  String name;

  @HiveField(2)
  double buyKeys;

  @HiveField(3)
  double buyMetal;

  @HiveField(4)
  double sellKeys;

  @HiveField(5)
  double sellMetal;

  Box fromJson(Map<String, dynamic> json) {
    var box = Hive.box('itemBox');
    var item = Item(
      name: json['name'],
      sku: json['sku'],
      buyKeys: json['buy']['keys'],
      buyMetal: json['buy']['metal'],
      sellKeys: json['sell']['keys'],
      sellMetal: json['sell']['metal'],
    );
    box.add(item);
    return box;
  }
}
