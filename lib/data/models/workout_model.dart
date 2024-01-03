class GetWorkOutObject {
  GetWorkOutObject({
    this.workOutTotal,
  });

  WorkOut? workOutTotal;

  factory GetWorkOutObject.fromMap(Map<String, dynamic> json) => GetWorkOutObject(
        workOutTotal: json["workOutTotal"] == null ? null : WorkOut.fromMap(json["workOutTotal"]),
      );
}

class WorkOut {
  WorkOut({
    required this.id,
    required this.description,
    required this.phase,
    required this.kcal,
    required this.distance,
    required this.maxSpeed,
    required this.writer,
    required this.createdAt,
    required this.updatedAt,
  });

  String? id;
  String? description;
  double? phase;
  double kcal;
  double? distance;
  double? maxSpeed;
  String? writer;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory WorkOut.fromMap(Map<String, dynamic> json) => WorkOut(
        id: json["id"] == null ? null : json["id"],
        description: json["description"] == null ? null : json["description"],
        phase: json["phase"] == null ? 0 : double.parse(json["phase"]),
        kcal: json["kcal"] == null ? 0 : double.parse(json["kcal"]),
        distance: json["distance"] == null ? 0 : double.parse(json["distance"]),
        maxSpeed: json["maxSpeed"] == null ? 0 : double.parse(json["maxSpeed"]),
        writer: json["writer"] == null ? null : json["writer"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'phase': phase,
        'kcal': kcal,
        'distance': distance,
        'maxSpeed': maxSpeed,
        'writer': writer,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
