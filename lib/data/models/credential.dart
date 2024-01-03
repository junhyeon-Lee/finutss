
enum Type{google, password, kakao}

class Credential {
  int userId;
  Type type;
  String token;
  String password;
  DateTime createdAt;
  DateTime updatedAt;

  Credential({
    required this.userId,
    required this.type,
    required this.token,
    required this.password,
    required this.createdAt,
    required this.updatedAt
  });

  factory Credential.fromMap(Map<String, dynamic> json) => Credential(
    userId: json["user_id"] == null ? null : json["user_id"],
    type: json["type"] == null ? null : json["type"],
    token: json["token"] == null ? null : json["token"],
    password: json["password"] == null ? null : json["password"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );
}