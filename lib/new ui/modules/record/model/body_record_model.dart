class WeightRecordModel {
  int? statusCode;
  String? message;
  Data? data;

  WeightRecordModel({this.statusCode, this.message, this.data});

  WeightRecordModel.fromJson(Map<String, dynamic> json) {
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
  List<WeightRecordArray>? weightRecordArray;
  int? count;

  Data({this.weightRecordArray, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['weightRecordArray'] != null) {
      weightRecordArray = <WeightRecordArray>[];
      json['weightRecordArray'].forEach((v) {
        weightRecordArray!.add(new WeightRecordArray.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weightRecordArray != null) {
      data['weightRecordArray'] =
          this.weightRecordArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class WeightRecordArray {
  String? id;
  String? userId;
  int? weightInKg;
  int? variationInWeight;
  String? createdAt;
  String? updatedAt;

  WeightRecordArray(
      {this.id,
        this.userId,
        this.weightInKg,
        this.variationInWeight,
        this.createdAt,
        this.updatedAt});

  WeightRecordArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    weightInKg = json['weightInKg'];
    variationInWeight = json['variationInWeight'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['weightInKg'] = this.weightInKg;
    data['variationInWeight'] = this.variationInWeight;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}


class WeightRecord{
  String id;
  String userId;
  int weightInKg;
  int weightCompare;
  String createdAt;
  bool isWeightLoss;

  WeightRecord(this.id, this.userId, this.weightInKg, this.weightCompare,
      this.createdAt,this.isWeightLoss);
}