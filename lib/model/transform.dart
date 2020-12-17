class Transform {
  final bool success;
  final String message;
  final String steamId;

  Transform({
    this.success,
    this.message,
    this.steamId,
  });

  factory Transform.fromJson(Map<String, dynamic> json) {
    return Transform(
      success: json['success'],
      message: json['message'],
      steamId: json['steamid'],
    );
  }
}
