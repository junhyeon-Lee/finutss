class GetTermsObject {
  GetTermsObject({
    this.terms,
  });

  Terms? terms;

  factory GetTermsObject.fromMap(Map<String, dynamic> json) => GetTermsObject(
        terms: json["terms"] == null ? null : Terms.fromMap(json["terms"]),
      );
}

class Terms {
  Terms({
    this.id,
    this.privatePolicy,
    this.termOfUse,
    this.receiveMarketInfo,
    this.updatedAt,
  });

  String? id;
  PrivatePolicy? privatePolicy;
  PrivatePolicy? termOfUse;
  PrivatePolicy? receiveMarketInfo;
  DateTime? updatedAt;

  factory Terms.fromMap(Map<String, dynamic> json) => Terms(
        id: json["id"] == null ? null : json["id"],
        privatePolicy: json["privatePolicy"] == null ? null : PrivatePolicy.fromMap(json["privatePolicy"]),
        termOfUse: json["termOfUse"] == null ? null : PrivatePolicy.fromMap(json["termOfUse"]),
        receiveMarketInfo: json["receiveMarketInfo"] == null ? null : PrivatePolicy.fromMap(json["receiveMarketInfo"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );
}

class PrivatePolicy {
  PrivatePolicy({
    this.content,
    this.images,
  });

  String? content;
  List<dynamic>? images;

  factory PrivatePolicy.fromMap(Map<String, dynamic> json) => PrivatePolicy(
        content: json["content"] == null ? null : json["content"],
        images: json["images"] == null ? null : List<dynamic>.from(json["images"].map((x) => x)),
      );
}
