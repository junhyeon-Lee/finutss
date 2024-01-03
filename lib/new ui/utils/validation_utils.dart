import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:get/get.dart';

class AppValidator {
  static String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static final validCharacters =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  static RegExp isValidSpecialChar=RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  static RegExp isValidNumber=RegExp(r"[0-9]");
 // static String passwordValid =r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])$';

  static String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return AppString.nameField;
    }
    return null;
  }

  static String? emailValidator(String? value) {
    RegExp regex = RegExp(emailPattern);
    if (value!.isEmpty) {
      return "PLEASE_ENTER_YOUR_EMAIL".tr;
    } else if (!regex.hasMatch(value)) {
      return "PLEASE_ENTER_A_VALID_EMAIL_FORM".tr;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "PLEASE_ENTER_YOUR_PASSWORD".tr;
    } else if (value.length < 6) {
      return 'PASSWORD_MUST_BE_MORE_THAN_6_CHARACTERS'.tr;
    }else if (value.length > 14) {
      return 'PASSWORD_MUST_BE_LESS_THAN_14_CHARACTERS'.tr;
    } else if (!value.contains(isValidSpecialChar)) {
      return "PLEASE_INCLUDE_614_CHARACTERS_ENGLISHNUMBERSPECIAL_CHARACTERS".tr;
    } else if (!value.contains(isValidNumber)) {
      return "PLEASE_INCLUDE_614_CHARACTERS_ENGLISHNUMBERSPECIAL_CHARACTERS".tr;
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator(String? value, String password) {
    if (value!.isEmpty) {
      return 'CONFIRM_PASSWORD'.tr;
    } else if (value.length < 6) {
      return 'PASSWORD_MUST_BE_MORE_THAN_6_CHARACTERS'.tr;
    }else if (value.length > 14) {
      return 'PASSWORD_MUST_BE_LESS_THAN_14_CHARACTERS'.tr;
    } else if (!value.contains(isValidSpecialChar)) {
      return "PLEASE_INCLUDE_614_CHARACTERS_ENGLISHNUMBERSPECIAL_CHARACTERS".tr;
    } else if (!value.contains(isValidNumber)) {
      return "PLEASE_INCLUDE_614_CHARACTERS_ENGLISHNUMBERSPECIAL_CHARACTERS".tr;
    } else if (value != password) {
      return "PASSWORDS_DO_NOT_MATCH".tr;
    } else {
      return null;
    }
  }

  static String? userNameValidator(String? value) {
    if (value!.isEmpty) {
      return AppString.nameField;
    } else {
      return null;
    }
  }

  static String? otpValidation(String? value) {
    if (value!.isEmpty) {
      return 'Enter Verification Code';
    } else {
      return null;
    }
  }
}
