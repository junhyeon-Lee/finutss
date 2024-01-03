
class Invite {
  int authorId;
  int targetId;
  DateTime createdAt;
  DateTime updatedAt;

  Invite({
    required this.authorId,
    required this.targetId,
    required this.createdAt,
    required this.updatedAt
  });

  factory Invite.fromMap(Map<String, dynamic> json) => Invite(
    authorId: json["author_id"] == null ? null : json["author_id"],
    targetId: json["target_id"] == null ? null : json["target_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );
}