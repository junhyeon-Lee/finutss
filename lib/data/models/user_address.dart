
class UserAddress {
  int userId;
  String city;
  String postalCode;
  String streetAddress;
  String additional;
  DateTime createdAt;
  DateTime updatedAt;

  UserAddress({
    required this.userId,
    required this.city,
    required this.postalCode,
    required this.streetAddress,
    required this.additional,
    required this.createdAt,
    required this.updatedAt
  });

  factory UserAddress.fromMap(Map<String, dynamic> json) => UserAddress(
    userId: json["user_id"] == null ? null : json["user_id"],
    city: json["city"] == null ? null : json["city"],
    postalCode: json["postal_code"] == null ? null : json["postal_code"],
    streetAddress: json["street_address"] == null ? null : json["street_address"],
    additional: json["additional"] == null ? null : json["additional"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

}