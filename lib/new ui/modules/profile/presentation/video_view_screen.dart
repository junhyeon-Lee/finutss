import 'package:cached_network_image/cached_network_image.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

// import 'package:pod_player_new/pod_player_new.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoViewScreen extends StatefulWidget {
  VideoViewScreen({
    required this.url,
    required this.pageIndex,
    required this.currentPageIndex,
    required this.isPaused,
    required this.type,
  });

  final int pageIndex;
  final int currentPageIndex;
  final bool isPaused;
  final String url;
  final int type;

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoViewScreen> {
  FlickManager? flickManager;
  PodPlayerController? controller;
  YoutubePlayerController? youtubePlayerController;
  bool initialized = false;

  @override
  void initState() {
    super.initState();

    if (widget.type == Constants.typeVideo) {
      if (widget.url.contains('youtu') || widget.url.contains('youtube')) {
        try {
          String? videoId = YoutubePlayer.convertUrlToId(widget.url);
          if (videoId != null) {
            youtubePlayerController = YoutubePlayerController(
                initialVideoId: videoId,
                /* podPlayerConfig: const PodPlayerConfig(
                autoPlay: false,
                isLooping: false,
                videoQualityPriority: [720, 360,144],
              ), ,*/
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  loop: false,
                    controlsVisibleAtStart: false
                ));
            initialized = true;
            youtubePlayerController?.play();
          }
        } on Exception catch (exception) {
          print('exception');
        } catch (error) {
          print('catch error');
        }
      } else {
        flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.network(
            widget.url,
          ),
          autoPlay: false,
        );
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    flickManager?.flickControlManager?.pause();
    controller?.pause();
  }

  @override
  void dispose() {
    flickManager?.dispose();
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pageIndex == widget.currentPageIndex && !widget.isPaused && initialized) {
      flickManager?.flickControlManager?.play();
      controller?.play();
    } else {
      // flickManager?.flickVideoManager?.videoPlayerController?.pause();
      flickManager?.flickControlManager?.pause();
      controller?.pause();
    }

    return Container(
      key: ValueKey('photo ${widget.pageIndex}'),
      child: widget.type == Constants.typePhoto
          ? CachedNetworkImage(
              imageUrl: widget.url,
              fit: BoxFit.cover,
              memCacheHeight: 800,
              maxHeightDiskCache: 800,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          : widget.url.contains('youtu') || widget.url.contains('youtube')
              ? Theme(
                  data: ThemeData(primaryColor: Colors.white),
                  child: YoutubePlayer(
                    controller: youtubePlayerController!,
                    showVideoProgressIndicator: true,
                  ),
                )
              /* PodVideoPlayer(
                    controller: controller!,
                    // pinpointId: widget.url,
                    videoAspectRatio: widget.url.contains('shorts') ? 9 / 16 : 16 / 9,
                    backgroundColor: AppColor.black,
                  ),
                )*/
              : FlickVideoPlayer(
                  flickManager: flickManager!,
                  flickVideoWithControls: FlickVideoWithControls(
                    closedCaptionTextStyle: TextStyle(fontSize: 8),
                    controls: FlickPortraitControls(),
                  ),
                ),
    );
  }

/* @override
  bool get wantKeepAlive => true;*/
}
