import 'package:get/get.dart';

class InviteUserModel {
  final String userProfile;
  final String userName;
  final String userDis;
  RxBool? isInviteFriend;
  InviteUserModel({
    required this.userName,
    required this.userDis,
    required this.userProfile,
    this.isInviteFriend,
  });
}
