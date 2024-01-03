
class Ban {
  String title;
  String description;
  String type;
  int authorId;
  int targetId;
  DateTime expiredAt;
  DateTime createdAt;
  DateTime updatedAt;

  Ban({
    required this.title,
    required this.description,
    required this.type,
    required this.authorId,
    required this.targetId,
    required this.expiredAt,
    required this.createdAt,
    required this.updatedAt
  });

  factory Ban.fromMap(Map<String, dynamic> json) => Ban(
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    type: json["type"] == null ? null : json["type"],
    authorId: json["author_id"] == null ? null : json["author_id"],
    targetId: json["target_id"] == null ? null : json["target_id"],
    expiredAt: json["expired_at"] == null ? null : json["expired_at"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );
}