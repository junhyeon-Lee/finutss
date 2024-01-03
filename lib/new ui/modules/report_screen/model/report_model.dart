class ReportModel {
  int? statusCode;
  String? message;
  Data? data;

  ReportModel({this.statusCode, this.message, this.data});

  ReportModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? reporterId;
  String? reportedId;
  String? reportCategory;
  String? reportDetail;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
      this.reporterId,
      this.reportedId,
      this.reportCategory,
      this.reportDetail,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reporterId = json['reporterId'];
    reportedId = json['reportedId'];
    reportCategory = json['reportCategory'];
    reportDetail = json['reportDetail'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reporterId'] = this.reporterId;
    data['reportedId'] = this.reportedId;
    data['reportCategory'] = this.reportCategory;
    data['reportDetail'] = this.reportDetail;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
