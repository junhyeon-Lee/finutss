class Notice {
  String title;
  String text;
  int views;
  String category;
  String status;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  Notice({
    required this.title,
    required this.text,
    required this.views,
    required this.category,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notice.fromMap(Map<String, dynamic> json) => Notice(
        title: json["title"] == null ? null : json["title"],
        text: json["text"] == null ? null : json["text"],
        views: json["views"] == null ? null : json["views"],
        category: json["category"] == null ? null : json["category"],
        status: json["status"] == null ? null : json["status"],
        userId: json["user_id"] == null ? null : json["user_id"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );
}
