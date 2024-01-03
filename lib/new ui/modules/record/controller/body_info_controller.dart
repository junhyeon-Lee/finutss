import 'dart:developer';
import 'package:finutss/new%20ui/modules/record/service/user_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:get/get.dart';

class BodyInfoController extends GetxController {




  @override
  void onInit() async {
    super.onInit();

    if(!Constants.isGuest) {
     /* WeightApiCall().then((value) {
      });*/
    }
  }





  Future<LoginModel> getUserInfo() async {
    try {
      LoginModel loginModel =
      await UserService.getUserInfo();
      if (loginModel.statusCode == Constants.successCode200) {
        //userModel.value=loginModel;
      }
      return loginModel;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
    return LoginModel();
  }


 /* void setBodyData(){
    bmiSliderController.selectWeight=userModel.value.data?.weightInKg?.toString() ?? '0';
    bmiSliderController.selectHeight=userModel.value.data?.heightInCm?.toString() ?? '0';
    bmiSliderController.selectGender=userModel.value.data?.gender?.toString() ?? 'Male';
    bmiSliderController.selectYearOfBirth=userModel.value.data?.yearOfBirth?.toString() ?? '0';

    bmiSliderController.selectIndexWeight.value = bmiSliderController.weightList.indexWhere((note) {
      return note.toString() == bmiSliderController.selectWeight;
    });

    bmiSliderController.selectIndexHeight.value = bmiSliderController.heightList.indexWhere((note) {
      return note.toString() == bmiSliderController.selectHeight;
    });

    bmiSliderController.selectIndexYear.value = bmiSliderController.yearList.indexWhere((note) {
      return note.toString() == bmiSliderController.selectYearOfBirth;
    });
  }*/
}
