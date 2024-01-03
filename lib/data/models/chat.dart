
class Chat {
  String title;
  String description;
  String type;
  int authorId;
  DateTime createdAt;
  DateTime updatedAt;

  Chat({
    required this.title,
    required this.description,
    required this.type,
    required this.authorId,
    required this.createdAt,
    required this.updatedAt
  });

  factory Chat.fromMap(Map<String, dynamic> json) => Chat(
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    type: json["type"] == null ? null : json["type"],
    authorId: json["author_id"] == null ? null : json["author_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );
}