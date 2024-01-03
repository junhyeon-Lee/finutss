class Report {
  String title;
  String description;
  String type;
  String link;
  int authorId;
  int targetId;
  String reportCategory;
  DateTime expiredAt;
  DateTime createdAt;
  DateTime updatedAt;

  Report(
      {required this.title,
      required this.description,
      required this.type,
      required this.link,
      required this.authorId,
      required this.targetId,
      required this.reportCategory,
      required this.expiredAt,
      required this.createdAt,
      required this.updatedAt});

  factory Report.fromMap(Map<String, dynamic> json) => Report(
      title: json["title"] == null ? null : json["title"],
      description: json["description"] == null ? null : json["description"],
      type: json["type"] == null ? null : json["type"],
      link: json["link"] == null ? null : json["link"],
      authorId: json["author_id"] == null ? null : json["author_id"],
      targetId: json["target_id"] == null ? null : json["target_id"],
      reportCategory:
          json["report_category"] == null ? null : json["report_category"],
      expiredAt: json["expired_at"] == null ? null : json["expired_at"],
      createdAt: json["created_at"] == null ? null : json["created_at"],
      updatedAt: json["updated_at"] == null ? null : json["updated_at"]);
}
