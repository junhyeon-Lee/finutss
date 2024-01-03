import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/channel_track/controller/channel_controller.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/map_view/controller/map_view_controller.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/user_model.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_detail_controller.dart';
import 'package:finutss/new%20ui/modules/track/model/commentModel.dart';
import 'package:finutss/new%20ui/modules/track/service/comment_service.dart';
import 'package:finutss/new%20ui/modules/track/service/track_service.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class CommentController extends GetxController {
  List<String> photoList = [
    'https://images.pexels.com/photos/1237119/pexels-photo-1237119.jpeg?cs=srgb&dl=pexels-jonathan-petersson-1237119.jpg&fm=jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/24701-nature-natural-beauty.jpg/1280px-24701-nature-natural-beauty.jpg',
    'https://i0.wp.com/dirt.asla.org/wp-content/uploads/2022/01/natural-garden_dirt.jpg?ssl=1',
    'https://akm-img-a-in.tosshub.com/indiatoday/images/story/202007/nature-3289812_1280_0.jpeg?size=690:388',
    'https://c1.wallpaperflare.com/preview/414/533/69/nature-royal-enfield-man-season.jpg',
    'https://images.unsplash.com/photo-1500622944204-b135684e99fd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmF0dXJhbHxlbnwwfHwwfHw%3D&w=1000&q=80'
  ];
  double scrollPosition = 0;
  RxList<CommentArray> commentList = RxList([]);
  RxList<Replies> replieyCommentList = RxList([]);
  TextEditingController controller = TextEditingController();
  RxBool isCommentLoading = false.obs;
  RxBool isRepliesOpen = false.obs;
  RxInt currentPageIndex = 1.obs;
  String selectUsername = '';
  String? parentCommentId;
  RxString profilePhoto = ''.obs;
  RxBool isOnPageTurning = false.obs;
  String currentTrackId = '';
  int totalParentComment = 0;
  int totalRepliesComment = 0;
  int itemIndex = (-1);
  int itemIndexMostPopular = (-1);
  int currentScreenType = (-1);
  late ChannelController channelController;
  final HomeScreenController homeController = Get.find();
  late TrackDetailController trackDetailController;

  FlickManager? flickManager;

  final ScrollController scrollController = ScrollController();
  final ScrollController repliesScrollController = ScrollController();
  RxBool isScrollPageView = true.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 100),
        );
      }
    });
  }

  void scrollDownRepliesComment() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (repliesScrollController.hasClients) {
        repliesScrollController.animateTo(
          repliesScrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 100),
        );
      }
    });
  }

  Future<void> getCurrentUser() async {
    LogInUser logInUser = (await SharedPrefs.getUser())!;
    profilePhoto.value = logInUser.profilePicture ?? '';
  }

  Future addComment({required String pinpointId, required String text, required String trackId, required bool isAddCommentForTrack}) async {
    AppLoader(Get.context!);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.baseUrl + ApiConstants.addComment),
    );
    Map<String, String> headers = {
      "Authorization": await SharedPrefs.getToken(),
    };
    if (isAddCommentForTrack) {
      request.fields['trackId'] = trackId;
    } else {
      request.fields['pinPointId'] = pinpointId;
    }

    request.fields['text'] = text;
    if (parentCommentId != null) {
      request.fields['parentCommentId'] = parentCommentId ?? '';
    }
    request.headers.addAll(headers);

    HttpClient httpClient = HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(httpClient);

    http.Response.fromStream(await ioClient.send(request)).then(
      (response) async {
        if (response.statusCode == Constants.successCode201) {
          try {
            final Map<String, dynamic> data = jsonDecode(response.body);
            if (data['statusCode'] == Constants.successCode200) {
              controller.text = '';

              int previousComment = totalParentComment;
              int previousRepliesComment = totalRepliesComment;
              await getComment(trackId: currentTrackId, pinpointId: pinpointId, isTrackThumbnail: isAddCommentForTrack);
              if (parentCommentId != null) {
                Map<String, dynamic> body = {
                  "trackId": currentTrackId,
                };
                if (!isAddCommentForTrack) {
                  body['pinPointId'] = pinpointId;
                }
                body['id'] = parentCommentId ?? '';
                await getReplaiesComment(body: body);
              }

              int count = (totalParentComment - previousComment) + (totalRepliesComment - previousRepliesComment);

              if (currentScreenType == Constants.trackDetailScreen) {
                trackDetailController.trackDetailModel.value.data?.comments?.count =
                    (trackDetailController.trackDetailModel.value.data?.comments?.count ?? 0) + count;
                trackDetailController.trackDetailModel.refresh();
              } else if (currentScreenType == Constants.mostPopularScreen) {
                homeController.mostPopularTrackList[itemIndexMostPopular].totalCommentsCount =
                    (homeController.mostPopularTrackList[itemIndexMostPopular].totalCommentsCount ?? 0) + count;
                homeController.mostPopularTrackList.refresh();
              } else if (currentScreenType == Constants.dailyTrackScreen) {
                homeController.dailyTrack.value.totalCommentsCount = (homeController.dailyTrack.value.totalCommentsCount ?? 0) + count;
                homeController.dailyTrack.refresh();
              } else if (currentScreenType == Constants.channelPopularTrack) {
                channelController.popularTrackList[itemIndexMostPopular].totalCommentsCount =
                    (channelController.popularTrackList[itemIndexMostPopular].totalCommentsCount ?? 0) + count;
                channelController.popularTrackList.refresh();
              } else if (currentScreenType == Constants.channelLatestTrack) {
                channelController.latestTrackList[itemIndexMostPopular].totalCommentsCount =
                    (channelController.latestTrackList[itemIndexMostPopular].totalCommentsCount ?? 0) + count;
                channelController.latestTrackList.refresh();
              }
            } else {}
          } catch (e) {
            rethrow;
          } finally {
            Navigation.pop();
          }
        } else {
          RemoveAppLoader();
        }
      },
    );
  }

  Future getComment({required bool isTrackThumbnail, required String trackId, String? pinpointId}) async {
    try {
      Map<String, dynamic> body = {
        "trackId": trackId,
      };
      if (!isTrackThumbnail) {
        body['pinPointId'] = pinpointId;
      }

      isCommentLoading.value = true;
      commentList.value = [];
      CommentModel model = await CommentService.getComment(body: body);
      if (model.statusCode == Constants.successCode200) {
        if (isTrackThumbnail) {
          List<CommentArray> list = model.data?.commentArray ?? [];
          list.removeWhere((item) => item.pinPointId != null);
          commentList.value = list;
          totalParentComment = list.length;
        } else {
          commentList.value = model.data?.commentArray ?? [];
          totalParentComment = model.data?.count ?? 0;
        }
        commentList.value.sort((a, b) {
          //sorting in ascending order
          return DateTime.parse(a.createdAt ?? '').compareTo(DateTime.parse(b.createdAt ?? ''));
        });

        scrollDown();
      }
      return CommentModel;
    } catch (e, st) {
      RemoveAppLoader();
    } finally {
      isCommentLoading.value = false;
    }
  }

  Future getReplaiesComment({required Map<String, dynamic> body}) async {
    try {
      isCommentLoading.value = true;
      CommentModel model = await CommentService.getComment(body: body);
      if (model.statusCode == Constants.successCode200) {
        replieyCommentList.value = model.data?.commentArray?[0].replies ?? [];

        totalRepliesComment = model.data?.commentArray?[0].repliesCount ?? 0;
        sortingReplaiesComment();
      }
      return CommentModel;
    } catch (e, st) {
      RemoveAppLoader();
    } finally {
      isCommentLoading.value = false;
    }
  }

  sortingReplaiesComment() {
    replieyCommentList.value.sort((a, b) {
      //sorting in ascending order
      return DateTime.parse(a.createdAt ?? '').compareTo(DateTime.parse(b.createdAt ?? ''));
    });

    scrollDownRepliesComment();
  }

  Future likeUnlike({required String status, required String commentID, required int index, required bool isOpenMapScreen}) async {
    try {
      Map<String, dynamic> body = {
        "commentId": commentID,
        "type": status,
      };
      SuccessModel model = await TrackService.setLikeUnlike(body: body);
      if (model.statusCode == Constants.successCode200) {
        if (commentList[index].isReacted ?? false) {
          if (commentList[index].reactionsCount != 0) {
            commentList[index].reactionsCount = (commentList[index].reactionsCount ?? 0) - 1;
          }
        } else {
          commentList[index].reactionsCount = (commentList[index].reactionsCount ?? 0) + 1;
        }
        commentList[index].isReacted = !(commentList[index].isReacted ?? false);
        commentList.refresh();

        if (isOpenMapScreen) {
          MapViewController mapViewController = Get.find();
          if (commentID == mapViewController.previewComments.value.id) {
            mapViewController.previewComments.value.isReacted = commentList[index].isReacted;
            mapViewController.previewComments.value.reactionsCount = commentList[index].reactionsCount;
            mapViewController.previewComments.refresh();
          }
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }
}
