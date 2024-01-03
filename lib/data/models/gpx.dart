
class GPX {
  int trackId;
  String longitude; ///TODO ??
  String latitude; ///TODO ??

  GPX({
    required this.trackId,
    required this.longitude,
    required this.latitude
  });

  factory GPX.fromMap(Map<String, dynamic> json) => GPX(
    trackId: json["track_id"] == null ? null : json["track_id"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    latitude: json["latitude"] == null ? null : json["latitude"],
  );
}