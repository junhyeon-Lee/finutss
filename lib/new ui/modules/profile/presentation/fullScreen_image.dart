import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finutss/new%20ui/modules/profile/controller/edit_profile_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pod_player/pod_player.dart';
import 'package:pod_player/pod_player.dart' as video;

// import 'package:pod_player_new/pod_player_new.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({Key? key, this.url, required this.type}) : super(key: key);
  String? url;
  int type;

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  final EditProfileController controller = Get.find();
  video.PodPlayerController? videoController;
  PodPlayerController? youtubeVideoController;
  late YoutubePlayerController youtubePlayerController;

  @override
  void initState() {
    super.initState();

    if (widget.type == Constants.typeVideo) {
      if ((widget.url ?? '').contains('youtu') || (widget.url ?? '').contains('youtube')) {
        try {
          print("Youtube Video----------> ${widget.url}");
          String? videoId = YoutubePlayer.convertUrlToId(widget.url /*"https://youtu.be/XQYEUsXBqBk"*/ ?? '');
          if (videoId != null) {
            // _controller = VideoPlayerController.network('https://www.youtube.com/watch?v=2572WVsX89E')
            //   ..initialize().catchError((error) {
            //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            //     print("Youtube Video error -----> ${error}");
            //     _controller.play();
            //   });
            // youtubeVideoController = PodPlayerController(
            //     playVideoFrom: PlayVideoFrom.youtube(videoId),
            //     podPlayerConfig: const PodPlayerConfig(autoPlay: true, isLooping: false, videoQualityPriority: [720, 360]))
            //   ..initialise().catchError((value) {
            //     print("Youtube Video----------> value -----> ${value}");
            //     // youtubeVideoController?.play();
            //   });

            youtubePlayerController = YoutubePlayerController(
                initialVideoId: videoId,
                /* podPlayerConfig: const PodPlayerConfig(
                autoPlay: false,
                isLooping: false,
                videoQualityPriority: [720, 360,144],
              ), ,*/
                flags: YoutubePlayerFlags(autoPlay: true, loop: false, controlsVisibleAtStart: false));
            // initialized = true;
            youtubePlayerController.play();
          }
        } on Exception catch (exception) {
          print('exception');
          print("Youtube Video exception----------> ${exception}");
        } catch (error) {
          print('catch error');
          print("Youtube Video error----------> ${error}");
        }
      } else {
        videoController = video.PodPlayerController(
          playVideoFrom: video.PlayVideoFrom.network(
            widget.url ?? '',
          ),
        )..initialise();
      }
    } else {
      if (widget.url == null) {
        widget.url = controller.avatarPath.value;
      }
    }
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.photoBgColor,
      ),
      child: Material(
        child: Container(
          color: AppColor.photoBgColor,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: widget.type == Constants.typeVideo ? videoView() : photoview(),
              ),
              Positioned(
                right: 4.w,
                top: 40.h,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30.w,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget videoView() {
    return Center(
      child: (widget.url ?? '').contains('youtu') || (widget.url ?? '').contains('youtube')
          ? Theme(
              data: ThemeData(primaryColor: Colors.white),
              child: YoutubePlayer(
                controller: youtubePlayerController!,
                showVideoProgressIndicator: true,
                progressColors: ProgressBarColors(),
              ), /*PodVideoPlayer(
                controller: youtubeVideoController!,
                backgroundColor: AppColor.black,
                // isShowFullScreenIcon: true,
                // pinpointId: widget.url ?? '',
              ),*/
            )
          : PodVideoPlayer(
              controller: videoController!,
              // pinpointId: widget.url ?? '',
              podProgressBarConfig: PodProgressBarConfig(
                padding: EdgeInsets.zero,
                playingBarColor: Colors.blue,
                circleHandlerColor: Colors.blue,
                backgroundColor: Colors.blueGrey,
              ),
            ),
    );
  }

  Widget photoview() {
    return Container(
      width: double.infinity,
      child: widget.url != null
          ? PhotoView(
              backgroundDecoration: BoxDecoration(color: AppColor.photoBgColor),
              imageProvider: CachedNetworkImageProvider(widget.url ?? ''),
            )
          : PhotoView(
              imageProvider: FileImage(
                File(
                  controller.avatarPath.value,
                ),
              ),
            ),
    );
  }
}
