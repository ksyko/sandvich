class Stats {
  final String tfChartsUpdateTimestamp;
  final String tfPlayers;
  final String gcStatus;
  final String mptfKeyPrice;
  final String scmKeyPrice;
  final String bptfKeyPrice;
  final String tfLastUpdate;

  Stats({
    this.tfChartsUpdateTimestamp,
    this.tfPlayers,
    this.gcStatus,
    this.mptfKeyPrice,
    this.scmKeyPrice,
    this.bptfKeyPrice,
    this.tfLastUpdate,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      tfChartsUpdateTimestamp: json['charts_update_time'].toString(),
      tfPlayers: json['charts_players'].toString(),
      gcStatus: json['gc_status'],
      mptfKeyPrice: json['mptf_key_price'],
      scmKeyPrice: json['scm_key_price'],
      bptfKeyPrice: json['bptf_key_price'],
      tfLastUpdate: json['tf_last_update'].toString(),
    );
  }
}
