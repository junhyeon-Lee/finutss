class GetWorkoutTotalObject {
  GetWorkoutTotalObject({
    required this.workOutTotal,
  });

  WorkOutTotal? workOutTotal;

  factory GetWorkoutTotalObject.fromMap(Map<String, dynamic> json) => GetWorkoutTotalObject(
        workOutTotal: json["workOutTotal"] == null ? null : WorkOutTotal.fromMap(json["workOutTotal"]),
      );
}

class WorkOutTotal {
  WorkOutTotal({
    required this.kcal,
    required this.duration,
    required this.distance,
  });

  double kcal;
  int duration;
  double distance;

  factory WorkOutTotal.fromMap(Map<String, dynamic> json) => WorkOutTotal(
        kcal: json["kcal"] == null ? null : json["kcal"].toDouble(),
        duration: json["duration"] == null ? null : json["duration"],
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
      );
}
