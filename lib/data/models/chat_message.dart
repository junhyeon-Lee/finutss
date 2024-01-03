
class ChatMessage {
  int authorId;
  String text;
  DateTime createdAt;
  DateTime updatedAt;

  ChatMessage({
    required this.authorId,
    required this.text,
    required this.createdAt,
    required this.updatedAt
  });

  factory ChatMessage.fromMap(Map<String, dynamic> json) => ChatMessage(
    authorId: json["author_id"] == null ? null : json["author_id"],
    text: json["text"] == null ? null : json["text"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"]
  );
}