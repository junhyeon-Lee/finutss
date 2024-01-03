
class Session {
  int userId;
  String refreshToken;
  String refreshTokenExpires;
  DateTime createdAt;
  DateTime updatedAt;

  Session({
    required this.userId,
    required this.refreshToken,
    required this.refreshTokenExpires,
    required this.createdAt,
    required this.updatedAt
  });

  factory Session.fromMap(Map<String, dynamic> json) => Session(
    userId: json["user_id"] == null ? null : json["user_id"],
    refreshToken: json["refresh_token"] == null ? null : json["refresh_token"],
    refreshTokenExpires: json["refresh_token_expires"] == null ? null : json["refresh_token_expires"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );
}