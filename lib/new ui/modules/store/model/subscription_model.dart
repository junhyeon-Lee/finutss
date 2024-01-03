class SubscriptionModel {
  int? statusCode;
  String? message;
  Data? data;

  SubscriptionModel({this.statusCode, this.message, this.data});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
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
  List<TransactionArray>? transactionArray;
  int? count;

  Data({this.transactionArray, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['transactionArray'] != null) {
      transactionArray = <TransactionArray>[];
      json['transactionArray'].forEach((v) {
        transactionArray!.add(new TransactionArray.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactionArray != null) {
      data['transactionArray'] =
          this.transactionArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class TransactionArray {
  String? id;
  String? userId;
  String? walletId;
  PurchaseTransactionDetails? purchaseTransactionDetails;
  String? type;
  String? status;
  BalanceBeforeTransaction? balanceBeforeTransaction;
  BalanceBeforeTransaction? value;
  BalanceBeforeTransaction? balanceAfterTransaction;
  String? createdAt;
  String? updatedAt;

  TransactionArray(
      {this.id,
        this.userId,
        this.walletId,
        this.purchaseTransactionDetails,
        this.type,
        this.status,
        this.balanceBeforeTransaction,
        this.value,
        this.balanceAfterTransaction,
        this.createdAt,
        this.updatedAt});

  TransactionArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    walletId = json['walletId'];
    purchaseTransactionDetails = json['purchaseTransactionDetails'] != null
        ? new PurchaseTransactionDetails.fromJson(
        json['purchaseTransactionDetails'])
        : null;
    type = json['type'];
    status = json['status'];
    balanceBeforeTransaction = json['balanceBeforeTransaction'] != null
        ? new BalanceBeforeTransaction.fromJson(
        json['balanceBeforeTransaction'])
        : null;
    value = json['value'] != null
        ? new BalanceBeforeTransaction.fromJson(json['value'])
        : null;
    balanceAfterTransaction = json['balanceAfterTransaction'] != null
        ? new BalanceBeforeTransaction.fromJson(json['balanceAfterTransaction'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['walletId'] = this.walletId;
    if (this.purchaseTransactionDetails != null) {
      data['purchaseTransactionDetails'] =
          this.purchaseTransactionDetails!.toJson();
    }
    data['type'] = this.type;
    data['status'] = this.status;
    if (this.balanceBeforeTransaction != null) {
      data['balanceBeforeTransaction'] =
          this.balanceBeforeTransaction!.toJson();
    }
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    if (this.balanceAfterTransaction != null) {
      data['balanceAfterTransaction'] = this.balanceAfterTransaction!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class PurchaseTransactionDetails {
  String? kind;
  String? orderId;
  String? countryCode;
  bool? autoRenewing;
  int? paymentState;
  int? purchaseType;
  String? startTimeMillis;
  String? subscriptionId;
  String? developerPayload;
  String? expiryTimeMillis;
  String? priceAmountMicros;
  String? priceCurrencyCode;
  int? acknowledgementState;

  PurchaseTransactionDetails(
      {this.kind,
        this.orderId,
        this.countryCode,
        this.autoRenewing,
        this.paymentState,
        this.subscriptionId,
        this.purchaseType,
        this.startTimeMillis,
        this.developerPayload,
        this.expiryTimeMillis,
        this.priceAmountMicros,
        this.priceCurrencyCode,
        this.acknowledgementState});

  PurchaseTransactionDetails.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    orderId = json['orderId'];
    countryCode = json['countryCode'];
    autoRenewing = json['autoRenewing'];
    paymentState = json['paymentState'];
    subscriptionId = json['subscriptionId'];
    purchaseType = json['purchaseType'];
    startTimeMillis = json['startTimeMillis'];
    developerPayload = json['developerPayload'];
    expiryTimeMillis = json['expiryTimeMillis'];
    priceAmountMicros = json['priceAmountMicros'];
    priceCurrencyCode = json['priceCurrencyCode'];
    acknowledgementState = json['acknowledgementState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['orderId'] = this.orderId;
    data['countryCode'] = this.countryCode;
    data['autoRenewing'] = this.autoRenewing;
    data['subscriptionId'] = this.subscriptionId;
    data['paymentState'] = this.paymentState;
    data['purchaseType'] = this.purchaseType;
    data['startTimeMillis'] = this.startTimeMillis;
    data['developerPayload'] = this.developerPayload;
    data['expiryTimeMillis'] = this.expiryTimeMillis;
    data['priceAmountMicros'] = this.priceAmountMicros;
    data['priceCurrencyCode'] = this.priceCurrencyCode;
    data['acknowledgementState'] = this.acknowledgementState;
    return data;
  }
}

class BalanceBeforeTransaction {
  int? trackPoints;
  int? energyPoints;

  BalanceBeforeTransaction({this.trackPoints, this.energyPoints});

  BalanceBeforeTransaction.fromJson(Map<String, dynamic> json) {
    trackPoints = json['trackPoints'];
    energyPoints = json['energyPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trackPoints'] = this.trackPoints;
    data['energyPoints'] = this.energyPoints;
    return data;
  }
}