class HomeModel {
  int? statusCode;
  String? message;
  Data? data;

  HomeModel({this.statusCode, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  DailyTrack? dailyTrack;
  List<WorkoutUsersArray>? workoutUsersArray;
  List<PopularTrackArray>? popularTrackArray;

  Data({this.dailyTrack,this.workoutUsersArray, this.popularTrackArray});


  Data.fromJson(Map<String, dynamic> json) {
    dailyTrack = json['dailyTrack'] != null ? new DailyTrack.fromJson(json['dailyTrack']) : null;
    if (json['workoutUsersArray'] != null) {
      workoutUsersArray = <WorkoutUsersArray>[];
      json['workoutUsersArray'].forEach((v) { workoutUsersArray!.add(new WorkoutUsersArray.fromJson(v)); });
    }
    if (json['popularTrackArray'] != null) {
      popularTrackArray = <PopularTrackArray>[];
      json['popularTrackArray'].forEach((v) { popularTrackArray!.add(new PopularTrackArray.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dailyTrack != null) {
      data['dailyTrack'] = this.dailyTrack!.toJson();
    }
    if (this.popularTrackArray != null) {
      data['popularTrackArray'] = this.popularTrackArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class DailyTrack {
  String? id;
  String? userId;
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
  String? dailyKey;
  dynamic distanceInMetres;
  dynamic durationInSeconds;
  dynamic kcal;
  String? gpxFile;
  int? totalUses;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Channel? channel;
  int? totalUsersCount;
  int? totalCommentsCount;
  int? totalReactionCount;
  int? totalPhotosCount;
  bool? isTrackLiked;
  MonetizationDetails? monetizationDetails;


  DailyTrack({this.id, this.userId, this.channelId, this.uniqueId, this.name, this.description, this.tags, this.previewImage, this.type, this.privacy, this.status, this.stage,this.dailyKey, this.distanceInMetres, this.durationInSeconds, this.kcal, this.gpxFile, this.totalUses, this.createdAt, this.updatedAt, this.deletedAt, this.channel, this.totalUsersCount, this.totalCommentsCount, this.totalReactionCount, this.totalPhotosCount,this.isTrackLiked, this.monetizationDetails});

  DailyTrack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
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
    dailyKey = json['dailyKey'];
    distanceInMetres = json['distanceInMetres'];
    durationInSeconds = json['durationInSeconds'];
    kcal = json['kcal'];
    gpxFile = json['gpxFile'];
    totalUses = json['totalUses'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    channel = json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
    totalUsersCount = json['totalUsersCount'];
    totalCommentsCount = json['totalCommentsCount'];
    totalReactionCount = json['totalReactionCount'];
    totalPhotosCount = json['totalPhotosCount'];
    isTrackLiked = json['isTrackLiked'];
    monetizationDetails = json['monetizationDetails'] != null ? new MonetizationDetails.fromJson(json['monetizationDetails']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
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
    data['dailyKey'] = this.dailyKey;
    data['distanceInMetres'] = this.distanceInMetres;
    data['durationInSeconds'] = this.durationInSeconds;
    data['kcal'] = this.kcal;
    data['gpxFile'] = this.gpxFile;
    data['totalUses'] = this.totalUses;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    data['totalUsersCount'] = this.totalUsersCount;
    data['totalCommentsCount'] = this.totalCommentsCount;
    data['totalReactionCount'] = this.totalReactionCount;
    data['totalPhotosCount'] = this.totalPhotosCount;
    data['isTrackLiked'] = this.isTrackLiked;
    if (this.monetizationDetails != null) {
      data['monetizationDetails'] = this.monetizationDetails!.toJson();
    }
    return data;
  }
}



class WorkoutUsersArray {
  String? id;
  String? gender;
  String? firstName;
  String? lastName;
  String? username;
  String? profilePhoto;
  String? description;
  bool? isFollowing;

  WorkoutUsersArray({this.id, this.gender, this.firstName, this.lastName, this.username, this.profilePhoto, this.description, this.isFollowing});

  WorkoutUsersArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    profilePhoto = json['profilePhoto'];
    description = json['description'];
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gender'] = this.gender;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['profilePhoto'] = this.profilePhoto;
    data['description'] = this.description;
    data['isFollowing'] = this.isFollowing;
    return data;
  }
}



class PopularTrackArray {
  String? id;
  String? userId;
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
  ParsedGpx? parsedGpx;
  dynamic distanceInMetres;
  dynamic durationInSeconds;
  dynamic kcal;
  String? gpxFile;
  int? totalUses;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Channel? channel;
  bool? isTrackLiked;
  int? totalCommentsCount;
  int? totalReactionCount;
  int? totalPhotosCount;
  MonetizationDetails? monetizationDetails;

  PopularTrackArray({this.id, this.userId, this.channelId, this.uniqueId, this.name, this.description, this.tags, this.previewImage, this.type, this.privacy, this.status, this.parsedGpx, this.stage, this.distanceInMetres, this.durationInSeconds, this.kcal, this.gpxFile, this.totalUses, this.createdAt, this.updatedAt, this.deletedAt, this.channel, this.isTrackLiked,this.totalReactionCount,this.totalPhotosCount,this.totalCommentsCount,this.monetizationDetails});

  PopularTrackArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
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
    parsedGpx = json['parsedGpx'] != null ? new ParsedGpx.fromJson(json['parsedGpx']) : null;
    distanceInMetres = json['distanceInMetres'];
    durationInSeconds = json['durationInSeconds'];
    kcal = json['kcal'];
    gpxFile = json['gpxFile'];
    totalUses = json['totalUses'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    channel = json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
    isTrackLiked = json['isTrackLiked'];
    totalCommentsCount = json['totalCommentsCount'];
    totalReactionCount = json['totalReactionCount'];
    totalPhotosCount = json['totalPhotosCount'];
    monetizationDetails = json['monetizationDetails'] != null ? new MonetizationDetails.fromJson(json['monetizationDetails']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
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
    if (this.parsedGpx != null) {
      data['parsedGpx'] = this.parsedGpx!.toJson();
    }
    data['distanceInMetres'] = this.distanceInMetres;
    data['durationInSeconds'] = this.durationInSeconds;
    data['kcal'] = this.kcal;
    data['gpxFile'] = this.gpxFile;
    data['totalUses'] = this.totalUses;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    data['isTrackLiked'] = this.isTrackLiked;
    data['totalCommentsCount'] = this.totalCommentsCount;
    data['totalReactionCount'] = this.totalReactionCount;
    data['totalPhotosCount'] = this.totalPhotosCount;
    if (this.monetizationDetails != null) {
      data['monetizationDetails'] = this.monetizationDetails!.toJson();
    }
    return data;
  }
}




class ParsedGpx {
  List<Tracks>? tracks;

  ParsedGpx({ this.tracks,});

  ParsedGpx.fromJson(Map<String, dynamic> json) {

    if (json['tracks'] != null) {
      tracks = <Tracks>[];
      json['tracks'].forEach((v) { tracks!.add(new Tracks.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tracks != null) {
      data['tracks'] = this.tracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Tracks {
  Distance? distance;

  Tracks({this.distance});

  Tracks.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null ? new Distance.fromJson(json['distance']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distance != null) {
      data['distance'] = this.distance!.toJson();
    }
    return data;
  }
}




class Distance {
  List<double>? cumul;
  double? total;

  Distance({this.cumul, this.total});

  Distance.fromJson(Map<String, dynamic> json) {
    cumul = json['cumul'].cast<double>();
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cumul'] = this.cumul;
    data['total'] = this.total;
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
  dynamic energyPointsRequired;
  dynamic trackPointsEarned;
  dynamic trackPointsTax;
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