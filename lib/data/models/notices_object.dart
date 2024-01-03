class GetNoticesObject {
  GetNoticesObject({
    this.notices,
  });

  List<Notice>? notices;

  factory GetNoticesObject.fromMap(Map<String, dynamic> json) =>
      GetNoticesObject(
        notices: json["notices"] == null
            ? null
            : List<Notice>.from(json["notices"].map((x) => Notice.fromMap(x))),
      );
}

class Notice {
  Notice({
    this.name,
    this.id,
    this.qnaCategory,
    this.content,
    this.images,
    this.link,
    this.createdAt,
    this.updatedAt,
  });

  String? name;
  String? id;
  dynamic qnaCategory;
  String? content;
  List<dynamic>? images;
  dynamic link;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Notice.fromMap(Map<String, dynamic> json) => Notice(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        qnaCategory: json["qnaCategory"],
        content: json["content"] == null ? null : json["content"],
        images: json["images"] == null
            ? null
            : List<dynamic>.from(json["images"].map((x) => x)),
        link: json["link"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );
}
