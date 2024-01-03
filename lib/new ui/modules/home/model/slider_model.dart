class SliderModel {
  double? version;
  List<Banners>? banners;

  SliderModel({this.version, this.banners});

  SliderModel.fromJson(Map<String, dynamic> json) {
    version = json['Version'];
    if (json['Banners'] != null) {
      banners = <Banners>[];
      json['Banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Version'] = this.version;
    if (this.banners != null) {
      data['Banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? imageUrl;
  String? linkUrl;

  Banners({this.imageUrl, this.linkUrl});

  Banners.fromJson(Map<String, dynamic> json) {
    imageUrl = json['ImageUrl'];
    linkUrl = json['LinkUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImageUrl'] = this.imageUrl;
    data['LinkUrl'] = this.linkUrl;
    return data;
  }
}