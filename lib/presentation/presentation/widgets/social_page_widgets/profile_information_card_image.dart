import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileInformationCardImage extends StatelessWidget {
  const ProfileInformationCardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Image.network(authController.user?.image?.url ??
        AuthController.userProfileDefaultPath);
  }
}
