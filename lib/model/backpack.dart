class Backpack {
  final double backpackValue;
  final double marketPrice;
  final String keyCount;
  final double metalCount;
  final String usedSlots;
  final String totalSlots;
  final double backpackValueUsd;

  Backpack({
    this.backpackValue,
    this.marketPrice,
    this.keyCount,
    this.metalCount,
    this.usedSlots,
    this.totalSlots,
    this.backpackValueUsd,
  });

  factory Backpack.fromJson(Map<String, dynamic> json) {
    return Backpack(
      backpackValue: json['backpack_value'],
      marketPrice: json['marketPrice'],
      keyCount: json['key_count'],
      metalCount: json['metal_count'],
      usedSlots: json['used_slots'],
      totalSlots: json['total_slots'],
      backpackValueUsd: json['backpack_value_usd'],
    );
  }
}
