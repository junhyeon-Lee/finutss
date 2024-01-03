
class Social {
  String title;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Social({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt
  });

  factory Social.fromMap(Map<String, dynamic> json) => Social(
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );
}