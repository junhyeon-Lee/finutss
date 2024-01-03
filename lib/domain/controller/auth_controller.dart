import 'dart:convert';
import 'dart:math';

import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/UserQueries.dart';
import 'package:finutss/data/graphql_operation/queries/index.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/main_old.dart';
import 'package:finutss/presentation/screens/main_page.dart';
import 'package:finutss/presentation/screens/signup_screens/agree_screen.dart';
import 'package:finutss/presentation/screens/signup_screens/sign_in_screen/signin_screen.dart';
import 'package:finutss/presentation/widgets/dialogs/sign_in_unapproved_dialogs/unapproved_account_dialog.dart';
import 'package:finutss/presentation/widgets/dialogs/signup_dialog/forget_password_dialog.dart';
import 'package:finutss/presentation/widgets/dialogs/signup_dialog/signup_welcome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  User? user;

  /// TODO
  //GetUsersObject? userDetail;
  //var userDetail; ///
  var userBMI = 0.0;

  var signupType = "email";

  /* -------------------------------- variables -------------------------------- */
  String? email, password, newPassword, confirmPassword, userName;
  String emailErrorText = '';
  String passwordErrorText = '';
  String confirmPasswordErrorText = '';
  String newPasswordErrorText = '';
  String userNameErrorText = '';
  String errorText = '';

  static String userProfileDefaultPath =
      "assets/images/finutss_default_profile.png";
  static String UserProfileImagePath = "/user/Image/";

  var emailCheck = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool isAcceptAllChecked = false;
  bool isSignUp = false;
  bool isTermsChecked = false;
  bool isPrivacyChecked = false;
  bool isMarketingChecked = false;
  bool isAgeChecked = false;
  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;
  bool isObscureNewPassword = true;
  bool emailValidated = false;
  bool passwordValidated = false;
  bool newPasswordValidated = false;
  bool confirmPasswordValidated = false;
  bool userNameValidated = false;

  /* -------------------------------- form keys ------------------------------- */
  var loginFormKey = GlobalKey<FormState>();
  var emailFormKey = GlobalKey<FormState>();
  var passwordFormKey = GlobalKey<FormState>();
  var signUpFormKey = GlobalKey<FormState>();

  /* ---------------------------- text controllers ---------------------------- */
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  TextEditingController newPasswordTextController = TextEditingController();
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController memoTextController = TextEditingController();

  /* ---------------------------- focus node ---------------------------- */
  FocusNode focusNodeEmailTextController = FocusNode();
  FocusNode focusNodePasswordTextController = FocusNode();
  FocusNode focusNodeConfirmPasswordTextController = FocusNode();
  FocusNode focusNodeNewPasswordTextController = FocusNode();
  FocusNode focusNodeUserNameTextController = FocusNode();
  FocusNode focusNodeMemoTextController = FocusNode();

  AuthController() {
    emailTextController.text = "ilconafter@gmail.com";
    passwordTextController.text = "vlad*240900";

    userNameTextController.text = 'vlad';
    newPasswordTextController.text = 'vlad*240900';
    confirmPasswordTextController.text = 'vlad*240900';
  }

  /* -------------------------------- functions ------------------------------- */
  login() async {
    var res1 = await GlobalBloc().queryMutate(
        DefaultQueries.LOGIN,
        {
          "data": {
            "email": emailTextController.text.trim(),
            "password": passwordTextController.text.trim()
          }
        },
        true);
    print("res1---->$res1");
    if (emailTextController.text == '') {
      emailErrorText = 'PLEASE_ENTER_YOUR_EMAIL'.tr;
      emailValidated = false;
    } else if (!emailCheck.hasMatch(emailTextController.text)) {
      emailErrorText = 'PLEASE_ENTER_A_VALID_EMAIL_FORM'.tr;
      emailValidated = false;
    }
    // errorText = '';
    else {
      emailValidated = true;
      emailErrorText = '';
    }

    if (passwordTextController.text == '') {
      passwordErrorText = 'PLEASE_ENTER_YOUR_PASSWORD'.tr;
      passwordValidated = false;
    } else if (!res1["success"]) {
      passwordErrorText = "PASSWORDS_DO_NOT_MATCH".tr;
    } else {
      passwordValidated = true;
      passwordErrorText = '';
    }

    update();
    if (emailValidated == true && passwordValidated == true) {
      callLoginApi();
    }
  }

  callLoginApi() async {
    isLoading(true);
    var res = await GlobalBloc().queryMutate(
        DefaultQueries.LOGIN,
        {
          "data": {
            "email": emailTextController.text.trim(),
            "password": passwordTextController.text.trim()
          }
        },
        true);
    if (res == null) {
      Get.dialog(
        UnApprovedAccountDialog(),
        barrierDismissible: false,
      );
    }
    if (!res["success"]) {
      print(res["message"]);
      return LocalDB.snackbar("Error", res["message"]);
    }

    YOUR_PERSONAL_ACCESS_TOKEN =
        await res["data"]["authUser"]["tokens"]["accessToken"];
    ACCESS_TOKEN_EXPIRES_AT =
        await res["data"]["authUser"]["tokens"]["accessTokenExpiresAt"];
    YOUR_PERSONAL_REFRESH_TOKEN =
        await res["data"]["authUser"]["tokens"]["refreshToken"];
    REFRESH_TOKEN_EXPIRES_AT =
        await res["data"]["authUser"]["tokens"]["refreshTokenExpiresAt"];

    print('----------');
    print(res["data"]["authUser"]["tokens"]["accessToken"]);

    LocalDB.setString('token', YOUR_PERSONAL_ACCESS_TOKEN);
    LocalDB.setInt('accessTokenExpiresAt', ACCESS_TOKEN_EXPIRES_AT);
    LocalDB.setString('refreshToken', YOUR_PERSONAL_REFRESH_TOKEN);
    LocalDB.setInt('refreshTokenExpiresAt', REFRESH_TOKEN_EXPIRES_AT);
    LocalDB.setInt('userAsGuest', 1);
    print("------userAsGuest---->>>${LocalDB.getInt("userAsGuest")}");
    passwordTextController.text = "";
    emailTextController.text = "";
    callApiMyUserInfo();
    Get.offAll(() => MainPage());
  }

  callLogOutApi(data) {
    isLoading(true);
    GlobalBloc().queryMutate(DefaultQueries.LOGOUT, {"data": data}).then((res) {
      if (!res["success"]) {
        return LocalDB.snackbar("Error", res["message"]);
      }
      LocalDB.remove('token');
      LocalDB.remove('accessTokenExpiresAt');
      LocalDB.remove('refreshToken');
      LocalDB.remove('refreshTokenExpiresAt');
      LocalDB.remove('userAsGuest');

      YOUR_PERSONAL_ACCESS_TOKEN = "";
      ACCESS_TOKEN_EXPIRES_AT = 0;
      YOUR_PERSONAL_REFRESH_TOKEN = "";
      REFRESH_TOKEN_EXPIRES_AT = 0;
      user = null;
      Get.offAll(() => SignInScreen());
    });
  }

  callApiMyUserInfo() async {
    print("-callUserInfoApi");
    late var userInfo;
    try {
      Map<String, dynamic> values = Map<String, dynamic>();
      userInfo = await GlobalBloc().queryRepo(UserQueries.USER, values);
      user = await User.fromMap(userInfo["data"]["getUser"]);
      if (user == null) return false;
      update();

      ///TODO
      //BMI

      /*
      var resUserBMI = await GlobalBloc().queryRepo(UserQueries.USER_BMI, values);
      if (!resUserBMI["success"]) {
        return LocalDB.snackbar("Error", resUserBMI["message"]);
      }
      userBMI = resUserBMI["data"]["userBMI"].toDouble();

      update();

       */
      return true;
    } catch (e, stacktrace) {
      print('Exception: ' + e.toString());
      print('Stacktrace: ' + stacktrace.toString());
      LocalDB.snackbar("Error", "Error login ${e.toString()}");
      return false;
    }
  }

  static callApIUserInfo(id) async {
    print("-callUserInfoApi");
    Map<String, dynamic> values = Map<String, dynamic>();
    values["findQuery"] = {"_id": id};

    var res = await GlobalBloc().queryRepo(UserQueries.USER_ONE, values);
    if (!res["success"]) {
      return LocalDB.snackbar("Error", res["message"]);
    }
    return res["data"]["userOne"];
  }

  emailVerification() {
    if (emailTextController.text == '') {
      emailErrorText = 'PLEASE_ENTER_YOUR_EMAIL'.tr;
      emailValidated = false;
    } else if (!emailCheck.hasMatch(emailTextController.text)) {
      emailErrorText = 'PLEASE_ENTER_A_VALID_EMAIL_FORM'.tr;
      emailValidated = false;
    }
    // errorText = '';
    else {
      emailValidated = true;
      emailErrorText = '';
    }
    update();
    if (emailValidated == true) {
      callFindpwd();
      emailTextController.clear();
    }
  }

  callFindpwd() {
    isLoading(true);
    update();
    Map<String, dynamic> params = Map<String, dynamic>();
    params["email"] = emailTextController.text.trim();
    GlobalBloc().queryRepo(UserQueries.FIND_PWD,
        {'email': emailTextController.text.trim()}).then((response) {
      if (response["data"]["findPwd"] == true) {
        LocalDB.snackbar("이메일을 보냈습니다", "받은 편지함을 확인");
      } else {
        LocalDB.snackbar("Error", "존재 하지 않는 메일입니다.");
      }
      isLoading(false);
      update();
    });
  }

  bool validateStructure(String value) {
    // String pattern = r'^(?=.*?[A-Z, a-z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,14}$';
    String pattern = r'^(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,14}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  passwordConfirmation(title, description) async {
    if (passwordTextController.text == '') {
      passwordErrorText = 'PLEASE_ENTER_YOUR_CURRENT_PASSWORD'.tr;
    } else {
      passwordErrorText = '';
    }

    if (newPasswordTextController.text == '') {
      newPasswordErrorText = 'PLEASE_ENTER_A_NEW_PASSWORD'.tr;
      newPasswordValidated = false;
    } else if (!validateStructure(newPasswordTextController.text)) {
      newPasswordErrorText =
          'PLEASE_INCLUDE_614_CHARACTERS_ENGLISHNUMBERSPECIAL_CHARACTERS'.tr;
      newPasswordValidated = false;
    } else {
      newPasswordValidated = true;
      newPasswordErrorText = '';
    }
    if (confirmPasswordTextController.text == '') {
      confirmPasswordErrorText = 'PLEASE_ENTER_YOUR_PASSWORD_ONE_MORE_TIME'.tr;
      confirmPasswordValidated = false;
    } else if (confirmPasswordTextController.text !=
        newPasswordTextController.text) {
      confirmPasswordErrorText = 'PASSWORDS_DO_NOT_MATCH'.tr;
      confirmPasswordValidated = false;
    } else {
      confirmPasswordValidated = true;
      confirmPasswordErrorText = '';
    }
    update();
    passwordFormKey.currentState!.save();
    if (newPasswordValidated == true && confirmPasswordValidated == true) {
      await callApiChangePassword(
          passwordTextController.text, newPasswordTextController.text);
      if (await callApiChangePassword(
          passwordTextController.text, newPasswordTextController.text)) {
        Get.dialog(ForgetPasswordDialog(description: description, title: title),
            barrierDismissible: false);
      } else {
        LocalDB.snackbar("Alert", "fail");
      }

      passwordTextController.clear();
      newPasswordTextController.clear();
      confirmPasswordTextController.clear();
    }
  }

  signUp() async {
    List nameCharList = userNameTextController.text.split(' ');
    int totalChar = 0;
    for (String chars in nameCharList as Iterable<String>) {
      totalChar = totalChar + chars.length;
    }
    if (userNameTextController.text.trim() == '') {
      userNameValidated = false;
      userNameErrorText = 'PLEASE_ENTER_A_VALID_NICKNAME_FORM'.tr;
    } else if (totalChar < 3 || totalChar > 12) {
      userNameValidated = false;
      userNameErrorText = 'PLEASE_ENTER_A_VALID_NICKNAME_FORM'.tr;
    } else {
      var res = await GlobalBloc().queryRepo(UserQueries.CHECK_USER,
          {"email": emailTextController.text.trim().toString()}, true);

      // "data": {"email": emailTextController.text.trim(), "password": passwordTextController.text.trim()}

      print(res);

      if (!res["data"]["isUserFree"]) {
        userNameErrorText = 'THIS_NICKNAME_IS_ALREADY_IN_USE'.tr;
        userNameValidated = false;
      } else {
        userNameValidated = true;
        userNameErrorText = '';
      }
    }

    ////////////////////////////////////////////////////////////
    if (emailTextController.text.trim() == '') {
      emailErrorText = 'PLEASE_ENTER_A_VALID_EMAIL_FORM'.tr;
      emailValidated = false;
    } else if (!emailCheck.hasMatch(emailTextController.text)) {
      emailErrorText = 'PLEASE_ENTER_A_VALID_EMAIL_FORM'.tr;
      emailValidated = false;
    }
    // errorText = '';
    else {
      var resEmail = await GlobalBloc().queryRepo(UserQueries.CHECK_USER,
          {"email": emailTextController.text.trim().toString()}, true);
      if (!resEmail['data']["isUserFree"]) {
        emailErrorText = 'THIS_EMAIL_IS_ALREADY_IN_USE'.tr;
        emailValidated = false;
      } else {
        emailValidated = true;
        emailErrorText = '';
      }
    }

    ////////////////////////////////////////////////////////////
    if (passwordTextController.text == '') {
      passwordErrorText = 'PLEASE_ENTER_YOUR_PASSWORD'.tr;
      passwordValidated = false;
    } else if (!validateStructure(passwordTextController.text)) {
      passwordErrorText =
          'PLEASE_INCLUDE_614_CHARACTERS_ENGLISHNUMBERSPECIAL_CHARACTERS'.tr;
      passwordValidated = false;
    }
    // errorText = '';
    else {
      passwordValidated = true;
      passwordErrorText = '';
    }

    if (confirmPasswordTextController.text == '') {
      confirmPasswordErrorText = 'PLEASE_ENTER_YOUR_PASSWORD_ONE_MORE_TIME'.tr;
      confirmPasswordValidated = false;
    } else if (passwordTextController.text !=
        confirmPasswordTextController.text) {
      confirmPasswordErrorText = 'PASSWORDS_DO_NOT_MATCH'.tr;
      passwordValidated = false;
    }
    // errorText = '';
    else {
      confirmPasswordValidated = true;
      confirmPasswordErrorText = '';
    }

    update();

    if (emailValidated == true &&
        userNameValidated == true &&
        passwordValidated == true &&
        confirmPasswordValidated == true) {
      Get.to(() => AgreeScreen());
    }
  }

  signUpSocial() async {
    signupType = "social";

    List nameCharList = userNameTextController.text.split(' ');
    int totalChar = 0;
    for (String chars in nameCharList as Iterable<String>) {
      totalChar = totalChar + chars.length;
    }
    if (userNameTextController.text.trim() == '') {
      userNameValidated = false;
      userNameErrorText = 'PLEASE_ENTER_A_VALID_NICKNAME_FORM'.tr;
    } else if (totalChar < 3 || totalChar > 12) {
      userNameValidated = false;

      userNameErrorText = 'PLEASE_ENTER_A_VALID_NICKNAME_FORM'.tr;
    } else {
      userNameValidated = true;
      userNameErrorText = '';

      confirmPasswordValidated = true;
      confirmPasswordErrorText = '';
    }
/*
    var res = await GlobalBloc().queryRepo(UserQueries.CHECK_USER, {
      'findQuery': {
        'nickName': userNameTextController.text.trim(),
        'status': {
          '\$in': ["active", "uncertified"]
        }
      }
    });
    if (res["data"]["checkUser"]) {
      userNameErrorText = 'THIS_NICKNAME_IS_ALREADY_IN_USE'.tr;
      userNameValidated = false;
    } else {
      userNameValidated = true;
      userNameErrorText = '';
    }


 */
    update();

    if (userNameValidated) {
      Get.to(() => AgreeScreen());
    }
  }

/* -----------------------  checks ----------------------- */
  passwordObscure() {
    isObscurePassword = !isObscurePassword;
    update();
  }

  newPasswordObscure() {
    isObscureNewPassword = !isObscureNewPassword;
    update();
  }

  confirmPasswordObscure() {
    isObscureConfirmPassword = !isObscureConfirmPassword;
    update();
  }

  acceptAll() {
    isAcceptAllChecked = !isAcceptAllChecked;
    if (isAcceptAllChecked) {
      isSignUp = true;
      isAgeChecked = true;
      isTermsChecked = true;
      isPrivacyChecked = true;
      isMarketingChecked = true;
      errorText = '';
    } else {
      isSignUp = false;
      isAgeChecked = false;
      isTermsChecked = false;
      isPrivacyChecked = false;
      isMarketingChecked = false;
    }

    update();
  }

  updateAllCheckStatus() {
    if (isAgeChecked &&
        isTermsChecked &&
        isPrivacyChecked &&
        isMarketingChecked) {
      isAcceptAllChecked = true;
      errorText = '';
    } else {
      isAcceptAllChecked = false;
    }

    if (isAgeChecked && isTermsChecked && isPrivacyChecked) {
      isSignUp = true;
    } else {
      isSignUp = false;
    }
  }

  ageChecked() {
    isAgeChecked = !isAgeChecked;
    updateAllCheckStatus();
    update();
  }

  termsChecked() {
    isTermsChecked = !isTermsChecked;
    updateAllCheckStatus();
    update();
  }

  privacyChecked() {
    isPrivacyChecked = !isPrivacyChecked;
    updateAllCheckStatus();
    update();
  }

  marketingChecked() {
    isMarketingChecked = !isMarketingChecked;
    updateAllCheckStatus();
    update();
  }

  onSignUpTerms() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (!isSignUp) {
      errorText = 'please check all options';
      update();
      return;
    }
    isLoading(true);
    if (signupType == "email") {
      GlobalBloc()
          .queryMutate(
              UserQueries.ADD_USER,
              {
                "data": {
                  "username": userNameTextController.text.trim(),
                  "email": emailTextController.text.trim(),
                  "password": passwordTextController.text.trim(),
                }
              },
              true)
          .then((res) {
        if (!res["success"]) {
          print(res['message']);
          LocalDB.snackbar("Alert", "failed to join the membership.");
          return;
        }
        // Get.to(SignInScreen());
        Get.dialog(SignUpWelcomeDialog(), barrierDismissible: false);
        update();
      });
    } else if (signupType == "social") {
      Map<String, dynamic> values = Map<String, dynamic>();
      var resUserInfo = await GlobalBloc().queryRepo(UserQueries.USER, values);
      if (!resUserInfo["success"]) {
        return LocalDB.snackbar("Error", resUserInfo["message"]);
      }
      user = resUserInfo["data"]["getUser"];

      GlobalBloc().queryMutate(UserQueries.UPDATE_USER, {
        "id": user?.userId,
        "data": {
          "nickName": userNameTextController.text.trim(),
          "status": "active"
        }
      }).then((res) {
        if (!res["success"]) {
          LocalDB.snackbar("Alert", "failed to join the membership.");
          return;
        }

        // Get.to(SignInScreen());
        Get.dialog(SignUpWelcomeDialog(), barrierDismissible: false);
        _prefs.setInt('guideIndex', 1);
        update();
      });
      emailTextController.clear();
      passwordTextController.clear();
      userNameTextController.clear();
      confirmPasswordTextController.clear();
    }
  }

  callApiUpdateUserInfo(data) {
    GlobalBloc().queryMutate(UserQueries.UPDATE_USER,
        {"id": user?.userId, "data": data}).then((res) {
      if (!res["success"]) {
        LocalDB.snackbar("Alert", "failed to save userInfo");
        return;
      }

      callApiMyUserInfo();
    });
  }

  callApiUpdateUserBiography(data) async {
    try {
      await GlobalBloc().queryMutate(UserQueries.UPDATE_USER_BIOGRAPHY,
          {"biography": data}).then((res) {});
      callApiMyUserInfo();
    } catch (e, stacktrace) {
      print('Exception: ' + e.toString());
      print('Stacktrace: ' + stacktrace.toString());
      LocalDB.snackbar("Error", "Error to save user biography ${e.toString()}");
      return;
    }
  }

  callApiChangePassword(password, newPassword) async {
    print("----------CHANGE PASSWORD------------");
    var res = await GlobalBloc().queryMutate(UserQueries.UPDATE_PASSWORD_APP,
        {"id": user?.userId, "password": password, "newPassword": newPassword});
    print("----------CHANGE PASSWORD------${res["success"]}------");
    print("----------CHANGE PASSWORD------${res}------");

    if (!res["success"]) {
      LocalDB.snackbar("Alert", "failed to save userInfo");
      return false;
    }
    callApiMyUserInfo();
    return true;
  }

  void clearData() {
    passwordErrorText = '';
    newPasswordErrorText = '';
    confirmPasswordErrorText = '';

    passwordTextController.clear();
    newPasswordTextController.clear();
    confirmPasswordTextController.clear();
  }

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  uploadImage(XFile image) async {
    var fileName =
        '${DateFormat('yMMdd-Hms').format(DateTime.now())}-${getRandomString(5)}';
    await uploadImagessss(image, fileName);

    callApiMyUserInfo();
  }

  uploadImagessss(var image, String filename) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://api.finutss.com/image/upload"),
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $YOUR_PERSONAL_ACCESS_TOKEN"
    };

    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.headers.addAll(headers);
    print(request.headers.toString());
    print(request.files.toString());
    print("request: " + request.toString());

    http.Response.fromStream(await request.send()).then((response) async {
      if (response.statusCode == 200) {
        print("Uploaded! ");
        print('response.body ' + response.body);
        var res = json.decode(response.body);

        print('------------');
        var result = await GlobalBloc().queryMutate(
            DefaultQueries.SINGLE_FILE_UPLOAD, {"imageId": res["result"]});
        print(result.toString());
      }
    });
  }

  removeImage() async {
    if (user?.image?.name != null) {
      var url = user?.image?.name;
      await GlobalBloc()
          .queryMutate(DefaultQueries.SINGLE_FILE_REMOVE, {"Key": url});
    }

    var params = {"image": null};
    print(params);
    callApiUpdateUserInfo(params);
  }
}
