class WalletModel {
  int? statusCode;
  String? message;
  Data? data;

  WalletModel({this.statusCode, this.message, this.data});

  WalletModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? status;
  EnergyPointWallet? energyPointWallet;
  TrackPointWallet? trackPointWallet;
  String? createdAt;
  String? updatedAt;
  ConvertedWallet? convertedWallet;

  Data(
      {this.id,
        this.userId,
        this.status,
        this.energyPointWallet,
        this.trackPointWallet,
        this.createdAt,
        this.updatedAt,
        this.convertedWallet});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    status = json['status'];
    energyPointWallet = json['energyPointWallet'] != null
        ? new EnergyPointWallet.fromJson(json['energyPointWallet'])
        : null;
    trackPointWallet = json['trackPointWallet'] != null
        ? new TrackPointWallet.fromJson(json['trackPointWallet'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    convertedWallet = json['convertedWallet'] != null
        ? new ConvertedWallet.fromJson(json['convertedWallet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['status'] = this.status;
    if (this.energyPointWallet != null) {
      data['energyPointWallet'] = this.energyPointWallet!.toJson();
    }
    if (this.trackPointWallet != null) {
      data['trackPointWallet'] = this.trackPointWallet!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.convertedWallet != null) {
      data['convertedWallet'] = this.convertedWallet!.toJson();
    }
    return data;
  }
}

class EnergyPointWallet {
  int? balance;

  EnergyPointWallet({this.balance});

  EnergyPointWallet.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    return data;
  }
}

class TrackPointWallet {
  int? tax;
  int? earned;
  int? balance;
  int? withdrawnTax;
  int? minimumBalance;
  int? withdrawnBalance;

  TrackPointWallet(
      {this.tax,
        this.earned,
        this.balance,
        this.withdrawnTax,
        this.minimumBalance,
        this.withdrawnBalance});

  TrackPointWallet.fromJson(Map<String, dynamic> json) {
    tax = json['tax'];
    earned = json['earned'];
    balance = double.parse(json['balance'].toString()).toInt();
    withdrawnTax = json['withdrawnTax'];
    minimumBalance = json['minimumBalance'];
    withdrawnBalance = json['withdrawnBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax'] = this.tax;
    data['earned'] = this.earned;
    data['balance'] = this.balance;
    data['withdrawnTax'] = this.withdrawnTax;
    data['minimumBalance'] = this.minimumBalance;
    data['withdrawnBalance'] = this.withdrawnBalance;
    return data;
  }
}

class ConvertedWallet {
  int? earned;
  int? tax;
  int? balance;

  ConvertedWallet({this.earned, this.tax, this.balance});

  ConvertedWallet.fromJson(Map<String, dynamic> json) {
    earned = json['earned'];
    tax = json['tax'];
    balance = double.parse(json['balance'].toString()).toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['earned'] = this.earned;
    data['tax'] = this.tax;
    data['balance'] = this.balance;
    return data;
  }
}