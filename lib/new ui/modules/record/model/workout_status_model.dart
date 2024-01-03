class WorkoutStatusModel{
  int? statusCode;
  String? message;
  Data? data;

  WorkoutStatusModel({this.statusCode, this.message, this.data});

  WorkoutStatusModel.fromJson(Map<String, dynamic> json) {
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
  int? weeklyBurntCaloriesGoal;
  int? totalBurntCaloriesCount;
  List<DailyStatus>? dailyStatus;

  Data(
      {this.weeklyBurntCaloriesGoal,
        this.totalBurntCaloriesCount,
        this.dailyStatus});

  Data.fromJson(Map<String, dynamic> json) {
    weeklyBurntCaloriesGoal = json['weeklyBurntCaloriesGoal'];
    totalBurntCaloriesCount = json['totalBurntCaloriesCount'];
    if (json['dailyStatus'] != null) {
      dailyStatus = <DailyStatus>[];
      json['dailyStatus'].forEach((v) {
        dailyStatus!.add(new DailyStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weeklyBurntCaloriesGoal'] = this.weeklyBurntCaloriesGoal;
    data['totalBurntCaloriesCount'] = this.totalBurntCaloriesCount;
    if (this.dailyStatus != null) {
      data['dailyStatus'] = this.dailyStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DailyStatus {
  String? date;
  int? burntCaloriesCount;

  DailyStatus({this.date, this.burntCaloriesCount});

  DailyStatus.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    burntCaloriesCount = json['burntCaloriesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['burntCaloriesCount'] = this.burntCaloriesCount;
    return data;
  }
}