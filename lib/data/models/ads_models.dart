class GetAdsObject {
  GetAdsObject({
    this.ads,
  });

  List<Ad>? ads;

  factory GetAdsObject.fromMap(Map<String, dynamic> json) => GetAdsObject(
        ads: json["ads"] == null ? null : List<Ad>.from(json["ads"].map((x) => Ad.fromMap(x))),
      );
}

class Ad {
  Ad({
    this.image,
    this.status,
    this.priority,
  });

  Image? image;
  String? status;
  int? priority;

  factory Ad.fromMap(Map<String, dynamic> json) => Ad(
        image: json["image"] == null ? null : Image.fromMap(json["image"]),
        status: json["status"] == null ? null : json["status"],
        priority: json["priority"] == null ? null : json["priority"],
      );
}

class Image {
  Image({
    required this.url,
  });

  String url;

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        url: json["url"] == null ? null : json["url"],
      );
}
