class PrivacyPolicyModel {
  double? version;
  String? content;

  PrivacyPolicyModel({this.version, this.content});

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    version = json['Version'];
    content = json['Content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Version'] = this.version;
    data['Content'] = this.content;
    return data;
  }
}
