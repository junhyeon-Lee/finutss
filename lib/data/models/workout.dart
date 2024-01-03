
class Workout {
  String title;
  String description;
  String status;
  int trackId;
  int userId;
  String stage;
  String kcal; ///TODO ??
  String distance; ///TODO ??
  String duration; ///TODO ??
  String maxSpeed;
  bool finish;
  String workoutType;
  bool isRecord;
  DateTime createdAt;
  DateTime updatedAt;

  Workout({
    required this.title,
    required this.description,
    required this.status,
    required this.trackId,
    required this.userId,
    required this.stage,
    required this.kcal,
    required this.distance,
    required this.duration,
    required this.maxSpeed,
    required this.finish,
    required this.workoutType,
    required this.isRecord,
    required this.createdAt,
    required this.updatedAt
  });

  factory Workout.fromMap(Map<String, dynamic> json) => Workout(
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    status: json["status"] == null ? null : json["status"],
    trackId: json["track_id"] == null ? null : json["track_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    stage: json["stage"] == null ? null : json["stage"],
    kcal: json["kcal"] == null ? null : json["kcal"],
    distance: json["distance"] == null ? null : json["distance"],
    duration: json["duration"] == null ? null : json["duration"],
    maxSpeed: json["max_speed"] == null ? null : json["max_speed"],
    finish: json["finish"] == null ? null : json["finish"],
    workoutType: json["workout_type"] == null ? null : json["workout_type"],
    isRecord: json["is_record"] == null ? null : json["is_record"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );
}











