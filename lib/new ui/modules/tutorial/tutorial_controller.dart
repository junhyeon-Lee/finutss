import 'dart:developer';

import 'package:finutss/new%20ui/modules/profile/service/update_profile_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/modules/tutorial/tutorial_bot_chat.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:get/get.dart';

class TutorialController extends GetxController {
  @override
  void onInit() {
    flowChat();
    super.onInit();
  }

  ///튜토리얼 스크린 콜
  @override
  void onReady() {
    super.onReady();
  }

  var pageCounter = 0.obs;
  var flowCounter = 0.obs;
  var dataCounter = 0.obs;
  var buttonIndex = 0.obs;
  List<TutorialBotChat> chat =[];
  List comment = [
    '안녕하세요. User name님.\n반가워요! 🙌',
    '피너츠는 실제 지리 정보를 기반으로,\n집 안에서 다양한 곳을 가볼 수 있는\n 소셜 피트니스 서비스에요.',
    '우선 기초적인 신체 정보가 필요해요.\n BMi를 바탕으로 최적의 권장 운동량을\n 계산하여 매일 매일의 맞춤 목표를 \n제공드리고 있어요.',
    '수집된 정보는 타인에게 공개되는 일 없이,\n 오직 권장 운동량을 계산하기 위해 사용되니\n 안심하셔도 됩니다.',

  ];

  bool isIntro = false;
  var height = 0.0.obs;
  var weight = 0.0.obs;
  var gender = ''.obs;
  var birth = ''.obs;


  Future<void> chatFlow(String text, bool user) async {
    TutorialBotChat newChat = TutorialBotChat(text: text, user: user,);
    chat.add(newChat);
    update();
  }


  Future<void> flowChat() async {
    chatFlow( comment[0],false);
    Future.delayed(const Duration(seconds: 2),(){
      chatFlow( comment[1],false);
    });
    Future.delayed(const Duration(seconds: 4),(){
      chatFlow( comment[2],false);
    });
    Future.delayed(const Duration(seconds: 6),(){
      chatFlow( comment[3],false);
      isIntro = true;
    });


  }

  void nextButton()=>buttonIndex++;


  Future<LoginModel> updateBodyInfo(bool isBack) async {
    AppLoader(Get.context!);
    try {
      Map<String, dynamic> body = {
        "heightInCm": height,
        "weightInKg": weight,
        "yearOfBirth": birth,
        "gender": gender,
      };
      LoginModel model = await UpdateProfileService.updateProfile(body: body);
      if (model.statusCode == Constants.successCode200) {
        Navigation.pop();
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
      return LoginModel();
    } finally {
      Navigation.pop();
      if (isBack) {
        Navigation.pop();
      }
    }
  }

}
