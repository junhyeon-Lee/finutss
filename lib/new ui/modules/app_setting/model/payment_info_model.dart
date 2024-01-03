import 'dart:convert';

PaymentInfoModel paymentInfoModelFromJson(String str) =>
    PaymentInfoModel.fromJson(json.decode(str));

String paymentInfoModelToJson(PaymentInfoModel data) =>
    json.encode(data.toJson());

class PaymentInfoModel {
  PaymentInfoModel({
    this.name,
    this.image,
  });

  String? name;
  String? image;

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) =>
      PaymentInfoModel(
        name: json["name"],
        image: json["Image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "Image": image,
      };
}
