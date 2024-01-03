
class ChatUser {
  int userId;
  int chatId;
  DateTime createdAt;
  DateTime updatedAt;

  ChatUser({
    required this.userId,
    required this.chatId,
    required this.createdAt,
    required this.updatedAt
  });

  factory ChatUser.fromMap(Map<String, dynamic> json) => ChatUser(
    userId: json["user_id"] == null ? null : json["user_id"],
    chatId: json["chat_id"] == null ? null : json["chat_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );
}