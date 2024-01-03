class TrackDetailModel {
  int? statusCode;
  String? message;
  Data? data;

  TrackDetailModel({this.statusCode, this.message, this.data});

  TrackDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? rawGpx;
  dynamic distanceInMetres;
  dynamic durationInSeconds;
  dynamic kcal;
  String? gpxFile;
  ParsedGpx? parsedGpx;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Channel? channel;
  PinPoints? pinPoints;
  Reactions? reactions;
  Comments? comments;
  dynamic totalUses;
  dynamic usersCount;
  MonetizationDetails? monetizationDetails;
  bool? isTrackLiked;

  Data({this.id, this.userId, this.channelId, this.uniqueId, this.name, this.description, this.tags, this.previewImage, this.type, this.privacy, this.status, this.parsedGpx, this.stage, this.dailyKey, this.rawGpx, this.distanceInMetres, this.durationInSeconds, this.kcal, this.gpxFile, this.createdAt, this.updatedAt, this.deletedAt, this.channel,this.pinPoints, this.comments,this.reactions, this.totalUses,this.usersCount,  this.monetizationDetails, this.isTrackLiked});

  Data.fromJson(Map<String, dynamic> json) {
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
    rawGpx = json['rawGpx'];
    parsedGpx = json['parsedGpx'] != null ? new ParsedGpx.fromJson(json['parsedGpx']) : null;
    distanceInMetres = json['distanceInMetres'];
    durationInSeconds = json['durationInSeconds'];
    kcal = json['kcal'];
    gpxFile = json['gpxFile'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    channel = json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
    pinPoints = json['pinPoints'] != null ? new PinPoints.fromJson(json['pinPoints']) : null;
    comments = json['comments'] != null ? new Comments.fromJson(json['comments']) : null;
    reactions = json['reactions'] != null ? new Reactions.fromJson(json['reactions']) : null;
    totalUses = json['totalUses'];
    usersCount = json['usersCount'];
    monetizationDetails = json['monetizationDetails'] != null ? new MonetizationDetails.fromJson(json['monetizationDetails']) : null;
    isTrackLiked = json['isTrackLiked'];
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
    data['rawGpx'] = this.rawGpx;
    if (this.parsedGpx != null) {
      data['parsedGpx'] = this.parsedGpx!.toJson();
    }
    data['distanceInMetres'] = this.distanceInMetres;
    data['durationInSeconds'] = this.durationInSeconds;
    data['kcal'] = this.kcal;
    data['gpxFile'] = this.gpxFile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    if (this.pinPoints != null) {
      data['pinPoints'] = this.pinPoints!.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.toJson();
    }
    if (this.reactions != null) {
      data['reactions'] = this.reactions!.toJson();
    }
    data['totalUses'] = this.totalUses;
    data['usersCount'] = this.usersCount;
    if (this.monetizationDetails != null) {
      data['monetizationDetails'] = this.monetizationDetails!.toJson();
    }
    data['isTrackLiked'] = this.isTrackLiked;
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

class Routes {
  String? cmt;
  String? src;
  String? desc;
  String? name;
  String? type;
  String? number;
  List<Points>? points;
  List<double>? slopes;
  Distance? distance;
  Elevation? elevation;

  Routes({this.cmt, this.src, this.desc, this.name, this.type, this.number, this.points, this.slopes, this.distance, this.elevation});

  Routes.fromJson(Map<String, dynamic> json) {
    cmt = json['cmt'];
    src = json['src'];
    desc = json['desc'];
    name = json['name'];
    type = json['type'];
    number = json['number'];
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) { points!.add(new Points.fromJson(v)); });
    }
    slopes = json['slopes'].cast<double>();
    distance = json['distance'] != null ? new Distance.fromJson(json['distance']) : null;
    elevation = json['elevation'] != null ? new Elevation.fromJson(json['elevation']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cmt'] = this.cmt;
    data['src'] = this.src;
    data['desc'] = this.desc;
    data['name'] = this.name;
    data['type'] = this.type;
    data['number'] = this.number;
    if (this.points != null) {
      data['points'] = this.points!.map((v) => v.toJson()).toList();
    }
    data['slopes'] = this.slopes;
    if (this.distance != null) {
      data['distance'] = this.distance!.toJson();
    }
    if (this.elevation != null) {
      data['elevation'] = this.elevation!.toJson();
    }
    return data;
  }
}

class Reactions {
  List<ReactionArray>? reactionArray;
  int? count;

  Reactions({this.reactionArray, this.count});

  Reactions.fromJson(Map<String, dynamic> json) {
    if (json['reactionArray'] != null) {
      reactionArray = <ReactionArray>[];
      json['reactionArray'].forEach((v) { reactionArray!.add(new ReactionArray.fromJson(v)); });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reactionArray != null) {
      data['reactionArray'] = this.reactionArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}


class ReactionArray {
  String? id;
  String? trackId;
  String? userId;
  String? type;
  String? createdAt;
  String? updatedAt;
  User? user;

  ReactionArray({this.id, this.trackId, this.userId, this.type, this.createdAt, this.updatedAt, this.user});

  ReactionArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackId = json['trackId'];
    userId = json['userId'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackId'] = this.trackId;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Points {
  double? ele;
  double? lat;
  double? lon;
  String? time;

  Points({this.ele, this.lat, this.lon, this.time});

  Points.fromJson(Map<String, dynamic> json) {
    ele = json['ele'];
    lat = json['lat'];
    lon = json['lon'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ele'] = this.ele;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['time'] = this.time;
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

class Elevation {
  double? avg;
  double? max;
  double? min;
  double? neg;
  double? pos;

  Elevation({this.avg, this.max, this.min, this.neg, this.pos});

  Elevation.fromJson(Map<String, dynamic> json) {
    avg = json['avg'];
    max = json['max'];
    min = json['min'];
    neg = json['neg'];
    pos = json['pos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg'] = this.avg;
    data['max'] = this.max;
    data['min'] = this.min;
    data['neg'] = this.neg;
    data['pos'] = this.pos;
    return data;
  }
}

class Metadata {
  String? desc;
  String? name;
  String? time;

  Metadata({this.desc, this.name, this.time});

  Metadata.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    name = json['name'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['name'] = this.name;
    data['time'] = this.time;
    return data;
  }
}


class PinPoints {
  List<PinPointArray>? pinPointArray;
  int? count;

  PinPoints({this.pinPointArray, this.count});

  PinPoints.fromJson(Map<String, dynamic> json) {
    if (json['pinPointArray'] != null) {
      pinPointArray = <PinPointArray>[];
      json['pinPointArray'].forEach((v) { pinPointArray!.add(new PinPointArray.fromJson(v)); });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pinPointArray != null) {
      data['pinPointArray'] = this.pinPointArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class PinPointArray {
  String? id;
  String? trackId;
  String? name;
  String? lat;
  String? lon;
  dynamic distanceInKm;
  int? serialNumber;
  String? feature;
  String? text;
  String? sound;
  String? image;
  String? video;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  PreviewComment? previewComment;

  PinPointArray({this.id, this.trackId, this.name, this.lat, this.lon, this.distanceInKm, this.serialNumber, this.feature, this.text, this.sound, this.image, this.video, this.createdAt, this.updatedAt, this.deletedAt,this.previewComment});

  PinPointArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackId = json['trackId'];
    name = json['name'];
    lat = json['lat'];
    lon = json['lon'];
    distanceInKm = json['distanceInKm'];
    serialNumber = json['serialNumber'];
    feature = json['feature'];
    text = json['text'];
    sound = json['sound'];
    image = json['image'];
    video = json['video'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    previewComment = json['previewComment'] != null ? new PreviewComment.fromJson(json['previewComment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackId'] = this.trackId;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['distanceInKm'] = this.distanceInKm;
    data['serialNumber'] = this.serialNumber;
    data['feature'] = this.feature;
    data['text'] = this.text;
    data['sound'] = this.sound;
    data['image'] = this.image;
    data['video'] = this.video;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.previewComment != null) {
      data['previewComment'] = this.previewComment!.toJson();
    }
    return data;
  }
}




class PreviewComment {
  String? id;
  String? pinPointId;
  String? trackId;
  String? userId;
  String? text;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? reactionsCount;
  Reactions? reactions;
  User? user;
  bool? isReacted;
  int? repliesCount;

  PreviewComment({this.id,  this.pinPointId, this.trackId, this.userId, this.text, this.status,  this.createdAt, this.updatedAt, this.reactionsCount, this.reactions, this.user, this.isReacted, this.repliesCount});

  PreviewComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pinPointId = json['pinPointId'];
    trackId = json['trackId'];
    userId = json['userId'];
    text = json['text'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    reactionsCount = json['reactionsCount'];
    reactions = json['reactions'] != null ? new Reactions.fromJson(json['reactions']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    isReacted = json['isReacted'];
    repliesCount = json['repliesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pinPointId'] = this.pinPointId;
    data['trackId'] = this.trackId;
    data['userId'] = this.userId;
    data['text'] = this.text;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['reactionsCount'] = this.reactionsCount;
    if (this.reactions != null) {
      data['reactions'] = this.reactions!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['isReacted'] = this.isReacted;
    data['repliesCount'] = this.repliesCount;
    return data;
  }
}



class Comments {
  List<CommentArray>? commentArray;
  int? count;

  Comments({this.commentArray, this.count});

  Comments.fromJson(Map<String, dynamic> json) {
    if (json['commentArray'] != null) {
      commentArray = <CommentArray>[];
      json['commentArray'].forEach((v) { commentArray!.add(new CommentArray.fromJson(v)); });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commentArray != null) {
      data['commentArray'] = this.commentArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class CommentArray {
  String? id;
  String? parentCommentId;
  String? pinPointId;
  String? trackId;
  String? userId;
  String? text;
  String? status;
  String? attachment;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  User? user;

  CommentArray({this.id, this.parentCommentId, this.pinPointId, this.trackId, this.userId, this.text, this.status, this.attachment, this.createdAt, this.updatedAt, this.deletedAt, this.user});

  CommentArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentCommentId = json['parentCommentId'];
    pinPointId = json['pinPointId'];
    trackId = json['trackId'];
    userId = json['userId'];
    text = json['text'];
    status = json['status'];
    attachment = json['attachment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentCommentId'] = this.parentCommentId;
    data['pinPointId'] = this.pinPointId;
    data['trackId'] = this.trackId;
    data['userId'] = this.userId;
    data['text'] = this.text;
    data['status'] = this.status;
    data['attachment'] = this.attachment;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? profilePhoto;

  User({this.id, this.firstName, this.lastName, this.username, this.profilePhoto});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    profilePhoto = json['profilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['profilePhoto'] = this.profilePhoto;
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
