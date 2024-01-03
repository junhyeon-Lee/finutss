import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finutss/new%20ui/modules/photo_video/controller/photo_video_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PhotoVideoView extends StatefulWidget {
  PhotoVideoView({Key? key, required this.controller, required this.index, required this.onTap, required this.isVisible}) : super(key: key);
  final PhotoVideoController controller;
  final int index;
  final RxBool isVisible;
  final VoidCallback onTap;

  @override
  State<PhotoVideoView> createState() => _PhotoVideoViewState();
}

class _PhotoVideoViewState extends State<PhotoVideoView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() => IgnorePointer(
          ignoring: widget.isVisible.value,
          child: InkWell(
            onTap: widget.onTap,
            child: Container(
              key: ValueKey('image ${widget.index}'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.w),
                child: widget.controller.photosList[widget.index].type == Constants.typeVideo
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if ((widget.controller.photosList[widget.index].url ?? '').contains('youtu') ||
                                      (widget.controller.photosList[widget.index].url ?? '').contains('youtube')) ...[
                                    ImageFiltered(
                                      imageFilter: ImageFilter.blur(
                                          sigmaX: widget.isVisible.value ? 10 : 0, sigmaY: widget.isVisible.value ? 10 : 0, tileMode: TileMode.decal),
                                      enabled: widget.isVisible.value,
                                      child: Center(
                                        child: CachedNetworkImage(
                                          memCacheHeight: 150,
                                          memCacheWidth: 150,
                                          maxHeightDiskCache: 150,
                                          maxWidthDiskCache: 150,
                                          imageUrl: getYoutubeThumbnail(widget.controller.photosList[widget.index].url ?? ''),
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    ImageFiltered(
                                      imageFilter: ImageFilter.blur(
                                          sigmaX: widget.isVisible.value ? 10 : 0, sigmaY: widget.isVisible.value ? 10 : 0, tileMode: TileMode.decal),
                                      enabled: widget.isVisible.value,
                                      child: FutureBuilder<File>(
                                        future: _generateThumbnail(widget.controller.photosList[widget.index].url ?? ''),
                                        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                            return Image.file(
                                              snapshot.data!,
                                              fit: BoxFit.cover
                                            );
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 4.w,
                            top: 4.h,
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: AppColor.whiteColor,
                            ),
                          )
                        ],
                      )
                    : ImageFiltered(
                        imageFilter: ImageFilter.blur(
                            sigmaX: widget.isVisible.value ? 10 : 0, sigmaY: widget.isVisible.value ? 10 : 0, tileMode: TileMode.decal),
                        enabled: widget.isVisible.value,
                        child: CachedNetworkImage(
                          imageUrl: widget.controller.photosList[widget.index].url ?? '',
                          fit: BoxFit.cover,
                          memCacheHeight: 150,
                          memCacheWidth: 150,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                        ),
                      ),
              ),
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;

  String getYoutubeThumbnail(String url) {
    //  String? videoId = convertUrlToId(url);
    String? videoId = YoutubePlayer.convertUrlToId(url);
    String thumbnailUrl = getThumbnail(videoId: videoId ?? "");
    return thumbnailUrl;
  }

  String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  Future<File> _generateThumbnail(String url) async {
    final String? _path = await VideoThumbnail.thumbnailFile(
      video: url,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      quality: 50,
    );

    print('-----path----->${_path}');
    return File(_path!);
  }

  String getThumbnail({
    required String videoId,
    String quality = 'sddefault',
    bool webp = true,
  }) =>
      webp ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp' : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';
}
