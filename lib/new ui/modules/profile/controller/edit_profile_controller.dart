import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/helper/toast_helper.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/profile/service/update_profile_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/user_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/validation_utils.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class EditProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<String> avatarPath = ''.obs;
  Rx<String> pickPhotoPath = ''.obs;
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  AppSettingController settingController=Get.find();
  RxString nickNameErrorMsg = ''.obs;
  RxString bioErrorMsg = ''.obs;
  RxString nickName = ''.obs;
  RxString bio = ''.obs;
  LogInUser logInUser = LogInUser();
  RxBool cancelUpdateButtonVisible=true.obs;



  Future<void> getCurrentUser() async {
    logInUser = (await SharedPrefs.getUser())!;
    avatarPath.value = logInUser.profilePicture ?? '';
    pickPhotoPath.value = logInUser.profilePicture ?? '';
    nickName.value = logInUser.name ?? '';
    bio.value = logInUser.bio ?? '';
  }

  avatarFromGallery() async {
    var localAvatar =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (localAvatar != null) {
      pickPhotoPath.value = localAvatar.path;
      update();
    }
  }

  void validationUserName(context) {
    nickNameErrorMsg.value =
        AppValidator.userNameValidator(nickNameController.text) ?? '';
    bioErrorMsg.value =
        AppValidator.userNameValidator(bioController.text) ?? '';
    if (nickNameErrorMsg.value.isEmpty && bioErrorMsg.value.isEmpty) {
      FocusScope.of(context).requestFocus(FocusNode());
      updateUserNameBio();
    }
  }



  Future<LoginModel> updateUserNameBio() async {
    AppLoader(Get.context!);
    try {

      Map<String, dynamic> body = {
        "username": nickNameController.text,
        "description": bioController.text,
      };
      LoginModel model = await UpdateProfileService.updateProfile(body: body);
      if (model.statusCode == Constants.successCode200) {
        await SharedPrefs.saveUsernameBio(
            model.data?.username ?? '',
            model.data?.description ?? '',
        );
        getCurrentUser();
        Navigation.pop();
        settingController.getCurrentUser();
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
      return LoginModel();
    }finally{
      Navigation.pop();
    }
  }



  Future<void> updateProfilePhoto({required bool isDefault}) async {
    AppLoader(Get.context!);
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(ApiConstants.baseUrl+ApiConstants.editProfile),
    );

    Map<String, String> headers = {
      "Authorization": await SharedPrefs.getToken(),
    };
    File file=File('');
    if(isDefault){
      final byteData = await rootBundle.load(IconAssets.defaultIcon);
      final file1 = File('${(await getTemporaryDirectory()).path}/image.png');
      file= await file1.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }else{
      file=File(pickPhotoPath.value);
    }

    request.files
        .add(await http.MultipartFile.fromPath('profilePhoto', file.path));
    request.headers.addAll(headers);


    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(httpClient);

    http.Response.fromStream(await ioClient.send(request))
        .then((response) async {

          print('-------edit profile res---->${response.toString()}');
      if (response.statusCode == Constants.successCode200) {
        try {
          final Map<String, dynamic> data = jsonDecode(response.body);
          print('-------edit profile res- data--->${data.toString()}');
          if (data['statusCode'] != Constants.successCode200) {
            if (data.containsKey('message')) {
              AppToast.toastMessage("${data['message']}");
            } else {
              AppToast.toastMessage("${data['error']}");
            }
          } else {
            Map<String, dynamic> map = json.decode(response.body);
            LoginModel model = LoginModel.fromJson(map);
            avatarPath.value = model.data?.profilePhoto ?? '';
            pickPhotoPath.value = model.data?.profilePhoto ?? '';

            await SharedPrefs.saveProfilePhoto(
              model.data?.profilePhoto ?? '',
            );
            settingController.getCurrentUser();
            Navigation.pop();
          }
        } catch (e) {
          rethrow;
        }finally{
          Navigation.pop();
        }
      }
    });
  }


  keyboardIsVisible(BuildContext context) {
     bool isVisible= !(MediaQuery.of(context).viewInsets.bottom == 0.0);
    if(!isVisible){
      cancelUpdateButtonVisible.value=true;
    }else{
      cancelUpdateButtonVisible.value=false;
    }
  }
}
