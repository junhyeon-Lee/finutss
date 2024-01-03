import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DummyDataController extends GetxController {
  /* ---------------------------------- lists --------------------------------- */
  List<Map> notificationList = [
    {
      'title': 'Beat the operatior!',
      'text': '\n\nChallenge now and get galaxy \nBuds pro! Events...',
      'icon': CommunityMaterialIcons.calendar_text_outline,
      'time': '7.27',
      'isFriendRequest': false
    },
    {
      'title': 'Inspection notice',
      'text': '\n\nChallenge now and get galaxy \nBuds pro! Events...',
      'icon': Icons.notifications_active_outlined,
      'time': '7.27',
      'isFriendRequest': false
    },
    {
      'title': 'Want to work out together?',
      'text': '\n\nCandyBlossom invited me. \nShall we workout together?',
      'icon': Icons.people_outline,
      'time': '',
      'isFriendRequest': true
    },
    {
      'title': 'Inspection notice',
      'text': '\n\nChallenge now and get galaxy \nBuds pro! Events...',
      'icon': Icons.notifications_active_outlined,
      'time': '7.27',
      'isFriendRequest': false
    },
    {
      'title': 'Want to work out together?',
      'text': '\n\nCandyBlossom invited me. \nShall we workout together?',
      'icon': Icons.people_outline,
      'time': '',
      'isFriendRequest': true
    },
  ];

  List<Map> userList = [
    {
      'imagePath': 'assets/images/user5.png',
    },
    {
      'imagePath': 'assets/images/user2.png',
    },
    {
      'imagePath': 'assets/images/user3.png',
    },
    {
      'imagePath': 'assets/images/user5.png',
    },
    {
      'imagePath': 'assets/images/user5.png',
    },
    {
      'imagePath': 'assets/images/user2.png',
    },
    {
      'imagePath': 'assets/images/user3.png',
    },
    {
      'imagePath': 'assets/images/user2.png',
    },
    {
      'imagePath': 'assets/images/user3.png',
    },
    {
      'imagePath': 'assets/images/user5.png',
    },
  ];

  List<Map> smallUserList = [
    {
      'imagePath': 'assets/images/user5.png',
    },
    {
      'imagePath': 'assets/images/user2.png',
    },
    {
      'imagePath': 'assets/images/user3.png',
    },
  ];

  List<Map> userWorkoutRecord = [
    {
      'iconColor': colorBlue,
      'value': '200',
      'textColor': colorBlue,
      'leftPosition': -2.0
    },
    {
      'iconColor': colorBlue,
      'value': '196',
      'textColor': colorBlue,
      'leftPosition': 57.0
    },
    {
      'iconColor': colorBlue,
      'value': '120',
      'textColor': colorBlue,
      'leftPosition': 107.0
    },
    {
      'iconColor': colorLightSilver,
      'value': '105',
      'textColor': colorPink,
      'leftPosition': 157.0
    },
    {
      'iconColor': colorLightSilver,
      'value': '105',
      'textColor': Colors.transparent,
      'leftPosition': 207.0
    },
    {
      'iconColor': colorLightSilver,
      'value': '105',
      'textColor': Colors.transparent,
      'leftPosition': 257.0
    },
  ];
}
