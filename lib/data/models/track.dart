import 'package:finutss/data/models/workout_model.dart';

class GpxPoint {
  int gpxId;
  double latitude;
  double longitude;

  GpxPoint(
      {required this.gpxId, required this.latitude, required this.longitude});

  factory GpxPoint.fromMap(Map<String, dynamic> json) => GpxPoint(
        gpxId: json["gpx_id"],
        longitude: double.parse(json["latitude"]),
        latitude: double.parse(json["longitude"]),
      );
}

class Track {
  int trackId;
  int? userId;
  int startGPXId;

  ///TODO ???
  int endGPXId;

  ///TODO ???
  String title;
  String? sName;
  String? eName;
  String description;
  double duration;
  double distance;

  ///TODO ???
  double? kcal;

  ///TODO ???
  String? createdAt;
  int? updatedAt;
  GpxPoint gpxStart;
  GpxPoint gpxEnd;
  WorkOut workOut;

  Track(
      {required this.trackId,
      required this.userId,
      required this.startGPXId,
      required this.endGPXId,
      required this.title,
      required this.sName,
      required this.eName,
      required this.description,
      required this.distance,
      required this.duration,
      required this.kcal,
      required this.createdAt,
      required this.updatedAt,
      required this.gpxStart,
      required this.gpxEnd,
      required this.workOut});

  factory Track.fromMap(Map<String, dynamic> json) => Track(
        trackId: json["track_id"],
        userId: json["user_id"],
        startGPXId: json["start_gpx_id"],
        endGPXId: json["end_gpx_id"],
        title: json["title"],
        sName: json["start_name"] != null ? json["start_name"] : "",
        eName: json["end_name"] != null ? json["end_name"] : "",
        description: json["description"],
        duration: json["duration"] == null ? 0 : double.parse(json["duration"]),
        distance: json["distance"] == null ? 0 : double.parse(json["distance"]),
        kcal: json["kcal"],
        createdAt: json["created_at"] != null ? json["created_at"] : null,
        updatedAt:
            json["updated_at"] != null ? int.parse(json["updated_at"]) : null,
        gpxStart: GpxPoint.fromMap(json["gpx_start"]),
        gpxEnd: GpxPoint.fromMap(json["gpx_end"]),
        workOut: WorkOut.fromMap(json["workout"][0]),
      );
}
