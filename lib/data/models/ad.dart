
class Ad {
  int adId;
  String? title;
  String? description;
  String contentSrc;
  String? url;
  String? status;
  int? priority;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Ad({
    required this.adId,
    required this.title,
    required this.description,
    required this.contentSrc,
    required this.url,
    required this.status,
    required this.priority,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ad.fromMap(Map<String, dynamic> json) => Ad(
    adId: json["ad_id"],
    title: json["title"],
    description: json["description"],
    contentSrc: json["content_src"],
    url: json["url"],
    status: json["status"],
    priority: json["priority"],
    userId: json["user_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updated_at"]
  );
}
