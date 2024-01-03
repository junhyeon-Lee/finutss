
class Comment {
  int commentableId;
  DateTime createdAt;
  DateTime updatedAt;

  Comment({
    required this.commentableId,
    required this.createdAt,
    required this.updatedAt
  });

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
    commentableId: json["commentable_id"] == null ? null : json["commentable_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );
}
