class TrackAnalysisModel {
  int? statusCode;
  String? message;
  Data? data;

  TrackAnalysisModel({this.statusCode, this.message, this.data});

  TrackAnalysisModel.fromJson(Map<String, dynamic> json) {
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
  List<TracksArray>? tracksArray;
  int? count;

  Data({this.tracksArray, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['tracksArray'] != null) {
      tracksArray = <TracksArray>[];
      json['tracksArray'].forEach((v) {
        tracksArray!.add(new TracksArray.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tracksArray != null) {
      data['tracksArray'] = this.tracksArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class TracksArray {
  String? id;
  String? channelId;
  String? uniqueId;
  String? name;
  String? description;
  String? tags;
  String? previewImage;
  String? type;
  String? privacy;
  String? status;
  String? stage;
  String? createdAt;
  int? checkInCount;
  int? checkInPercentage;
  int? usersCount;
  int? finishedCount;
  dynamic finishedPercentage;
  dynamic avgDistanceInKm;
  dynamic avgTimeInMin;
  dynamic totalUses;
  dynamic distanceInMetres;
  Channel? channel;
  int? totalCommentsCount;
  int? totalReactionCount;
  int? totalPhotosCount;
  MonetizationDetails? monetizationDetails;
  bool? isTrackLiked;

  TracksArray(
      {this.id,
      this.channelId,
      this.uniqueId,
      this.name,
      this.description,
      this.tags,
      this.previewImage,
      this.type,
      this.privacy,
      this.status,
      this.stage,
      this.createdAt,
      this.checkInCount,
      this.checkInPercentage,
      this.usersCount,
      this.finishedCount,
      this.finishedPercentage,
      this.avgDistanceInKm,
      this.avgTimeInMin,
      this.totalUses,
      this.distanceInMetres,
      this.channel,
      this.totalCommentsCount,
      this.totalReactionCount,
      this.totalPhotosCount,
      this.monetizationDetails,
      this.isTrackLiked});

  TracksArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelId = json['channelId'];
    uniqueId = json['uniqueId'];
    name = json['name'];
    description = json['description'];
    tags = json['tags'];
    previewImage = json['previewImage'];
    type = json['type'];
    privacy = json['privacy'];
    status = json['status'];
    stage = json['stage'];
    createdAt = json['createdAt'];
    checkInCount = json['checkInCount'];
    checkInPercentage = json['checkInPercentage'];
    usersCount = json['usersCount'];
    finishedCount = json['finishedCount'];
    finishedPercentage = json['finishedPercentage'];
    avgDistanceInKm = json['avgDistanceInKm'];
    avgTimeInMin = json['avgTimeInMin'];
    totalUses = json['totalUses'];
    distanceInMetres = json['distanceInMetres'];
    channel = json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
    totalCommentsCount = json['totalCommentsCount'];
    totalReactionCount = json['totalReactionCount'];
    totalPhotosCount = json['totalPhotosCount'];
    monetizationDetails =
        json['monetizationDetails'] != null ? new MonetizationDetails.fromJson(json['monetizationDetails']) : null;
    isTrackLiked = json['isTrackLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['channelId'] = this.channelId;
    data['uniqueId'] = this.uniqueId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['previewImage'] = this.previewImage;
    data['type'] = this.type;
    data['privacy'] = this.privacy;
    data['status'] = this.status;
    data['stage'] = this.stage;
    data['createdAt'] = this.createdAt;
    data['checkInCount'] = this.checkInCount;
    data['checkInPercentage'] = this.checkInPercentage;
    data['usersCount'] = this.usersCount;
    data['finishedCount'] = this.finishedCount;
    data['finishedPercentage'] = this.finishedPercentage;
    data['avgDistanceInKm'] = this.avgDistanceInKm;
    data['avgTimeInMin'] = this.avgTimeInMin;
    data['totalUses'] = this.totalUses;
    data['distanceInMetres'] = this.distanceInMetres;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    data['totalCommentsCount'] = this.totalCommentsCount;
    data['totalReactionCount'] = this.totalReactionCount;
    data['totalPhotosCount'] = this.totalPhotosCount;
    if (this.monetizationDetails != null) {
      data['monetizationDetails'] = this.monetizationDetails!.toJson();
    }
    data['isTrackLiked'] = this.isTrackLiked;
    return data;
  }
}

class Channel {
  String? id;
  String? name;
  String? description;
  String? image;
  String? bannerImage;
  Settings? settings;

  Channel({this.id, this.name, this.description, this.image, this.bannerImage, this.settings});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    bannerImage = json['bannerImage'];
    settings = json['settings'] != null ? new Settings.fromJson(json['settings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['bannerImage'] = this.bannerImage;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}




class Settings {
  bool? isOfficial;
  dynamic hideComments;
  dynamic allowComments;

  Settings({this.isOfficial, this.hideComments, this.allowComments});

  Settings.fromJson(Map<String, dynamic> json) {
    isOfficial = json['isOfficial'];
    hideComments = json['hideComments'];
    allowComments = json['allowComments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOfficial'] = this.isOfficial;
    data['hideComments'] = this.hideComments;
    data['allowComments'] = this.allowComments;
    return data;
  }
}


class MonetizationDetails {
  int? energyPointsRequired;
  int? trackPointsEarned;
  int? trackPointsTax;
  dynamic trackPointsIssued;

  MonetizationDetails({this.energyPointsRequired, this.trackPointsEarned, this.trackPointsTax, this.trackPointsIssued});

  MonetizationDetails.fromJson(Map<String, dynamic> json) {
    energyPointsRequired = json['energyPointsRequired'];
    trackPointsEarned = json['trackPointsEarned'];
    trackPointsTax = json['trackPointsTax'];
    trackPointsIssued = json['trackPointsIssued'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['energyPointsRequired'] = this.energyPointsRequired;
    data['trackPointsEarned'] = this.trackPointsEarned;
    data['trackPointsTax'] = this.trackPointsTax;
    data['trackPointsIssued'] = this.trackPointsIssued;
    return data;
  }
}
