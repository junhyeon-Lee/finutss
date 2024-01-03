class BMIModel {
  int? statusCode;
  String? message;
  Data? data;

  BMIModel({this.statusCode, this.message, this.data});

  BMIModel.fromJson(Map<String, dynamic> json) {
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
  int? bmi;

  Data({this.bmi});

  Data.fromJson(Map<String, dynamic> json) {
    bmi = json['bmi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bmi'] = this.bmi;
    return data;
  }
}