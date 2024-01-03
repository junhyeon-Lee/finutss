class GetTrackObject {
  GetTrackObject({
    this.track,
  });

  Tracks? track;

  factory GetTrackObject.fromMap(Map<String, dynamic> json) => GetTrackObject(
        track:
            json["tracks"] == null ? null : Tracks.fromMap(json["tracks"][0]),
      );
}

class Tracks {
  Tracks({
    this.geojson,
    required this.title,
    required this.sName,
    required this.eName,
    required this.description,
    required this.kcal,
    required this.distance,
    required this.duration,
    required this.dayOfTheWeek,
    required this.image,
  });

  var geojson;
  String title;
  String sName;
  String eName;
  String description;
  double kcal;
  double distance;
  int duration;
  int dayOfTheWeek;
  String image;

  // double kcal;
  // int duration;
  // double distance;

  factory Tracks.fromMap(Map<String, dynamic> json) {
    return Tracks(
      // kcal: json["kcal"] == null ? null : json["kcal"].toDouble(),
      // duration: json["duration"] == null ? null : json["duration"],
      // distance: json["distance"] == null ? null : json["distance"].toDouble(),

      geojson: json["geojson"] == null ? null : json["geojson"],
      title: json["title"] == null ? null : json["title"],
      sName: json["sName"] == null ? null : json["sName"],
      eName: json["eName"] == null ? null : json["eName"],
      description: json["description"] == null ? null : json["description"],
      kcal: json["kcal"] == null ? null : json["kcal"].toDouble(),
      distance: json["distance"] == null ? null : json["distance"].toDouble(),
      duration: json["duration"] == null ? null : json["duration"],
      dayOfTheWeek: json["dayOfTheWeek"] == null ? null : json["dayOfTheWeek"],
      image: json["image"] == null ? null : json["image"]["url"],
    );
  }
}
