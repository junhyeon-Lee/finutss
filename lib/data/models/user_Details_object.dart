
class UsersDetails {
  UsersDetails({
    required this.userId,
    required this.sex,
    required this.height,
    required this.weight,
    required this.bmr,
  });


  String userId;
  String? sex;
  double height;
  double weight;
  double bmr;

  factory UsersDetails.fromMap(Map<String, dynamic> json) => UsersDetails(
    userId: json["userId"] == null ? null : json["userId"],
    bmr: json["bmr"] == null ? 0 : json["bmr"].toDouble(),
    height: json["height"] == null ? 0 : json["height"].toDouble(),
    weight: json["weight"] == null ? 0 : json["weight"].toDouble(),
    sex: json["sex"] == null ? null : json["sex"],
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'sex': sex,
    'height': height,
    'weight': weight,
    'bmr': bmr,
  };
}
