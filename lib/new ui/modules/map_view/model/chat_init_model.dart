class ChatInitModel {
  int? statusCode;
  String? message;
  Data? data;

  ChatInitModel({this.statusCode, this.message, this.data});

  ChatInitModel.fromJson(Map<String, dynamic> json) {
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
  String? chatId;

  Data({this.id, this.chatId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chatId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chatId'] = this.chatId;
    return data;
  }
}