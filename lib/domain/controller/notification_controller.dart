import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/event_controller.dart';
import 'package:finutss/domain/controller/follower_controller.dart';
import 'package:finutss/domain/controller/invite_friends_controller.dart';
import 'package:finutss/domain/controller/notice_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final noticeController = Get.put(NoticeController());
  final eventController = Get.put(EventController());
  final followerController = Get.put(FollowerController());
  final inviteFriendsController = Get.put(InviteFriendsController());
  final authController = Get.put(AuthController());

  List<Map> notificationList = [
    {
      'title': 'Beat the operatior!',
      'text': 'Challenge now and get galaxy \nBuds pro! Events...',
      'icon': CommunityMaterialIcons.calendar_text_outline,
      'time': '7.27',
      'isFriendRequest': false
    },
    {
      'title': 'Inspection notice',
      'text': 'Challenge now and get galaxy \nBuds pro! Events...',
      'icon': Icons.notifications_active_outlined,
      'time': '7.27',
      'isFriendRequest': false
    },
    {
      'title': 'WANT_TO_WORKOUT_TOGHTHER',
      'text': 'WHO_INVITED_MENSHALL_WE_WORKOUT_TOGETHER',
      'icon': Icons.people_outline,
      'time': '',
      'isFriendRequest': true
    },
    {
      'title': 'Inspection notice',
      'text': 'Challenge now and get galaxy \nBuds pro! Events...',
      'icon': Icons.notifications_active_outlined,
      'time': '7.27',
      'isFriendRequest': false
    },
    {
      'title': 'WANT_TO_WORKOUT_TOGHTHER',
      'text': 'WHO_INVITED_MENSHALL_WE_WORKOUT_TOGETHER',
      'icon': Icons.people_outline,
      'time': '',
      'isFriendRequest': true
    },
  ];
}
