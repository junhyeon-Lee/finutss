class PhotoVideoModel{
  String? url;
  int type;
  String? pinPointId;
  int serialNumber;
  bool? isTrackThumbnail;

  PhotoVideoModel({this.url, required this.type, this.pinPointId, required this.serialNumber,this.isTrackThumbnail});
}
