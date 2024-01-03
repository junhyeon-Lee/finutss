class Image {
  String? name;
  String? url;

  Image({
    required this.name,
    required this.url,
  });

  factory Image.fromMap(Map<String, dynamic> json) => Image(
    url: json["src"] == null ? null : json["src"],
    name: json["name"] == null ? null : json["name"], ///TODO
  );
}