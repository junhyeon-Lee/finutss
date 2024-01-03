import 'dart:developer';

class ApiConstants {


  // static const String baseUrl = "https://api-dev.finutss.com/";
  static const String baseUrl = "https://api.finutss.com/";
  // static const String baseUrl = "http://13.124.197.107:3001/";
  // static const String baseUrl = "http://192.168.29.133:3002/";
  static const String register = "user/signup";
  static const String logIn = "user/login";
  static const String forgotPassword = "user/password/forgot";
  static const String forgotPasswordWithOTP = "user/password/forgot";
  static const String verifyOTP = "user/password/verify/otp";
  static const String createPassword = "user/password/reset";
  static const String changePassword = "user/password";
  static const String editProfile = "user";
  static const String getUserInfo = "user/info";
  static const String searchFriend = "user/search";
  static const String getUserById = "user/search";
  static const String logOut = "user/logout";
  static const String addUserBlackList = "blacklist";
  static const String removeUserBlackList = "blacklist/blacklist/";
  static const String GetBodyRecord = "weight-record";
  static const String DeleteBodyRecord = "weight-record/";
  static const String addComment = "comment";
  static const String follow = "follow";
  static const String googleSignUp = "user/auth/google/redirect";
  static const String googleLogin = "user/auth/google";
  static const String kaKaoRegister = "user/auth/kakao/redirect";
  static const String kaKaoLogin = "user/auth/kakao";
  static const String report = "report";
  static const String todayRecord = "record/today-record";
  static const String getRecord = "record";
  static const String updateRecord = "record/";
  static const String createRecord = "record";
  static const String getBmi = "user/bmi";
  static const String workoutStatus = "user/workout/status";
  static const String recommendedUser = "user/suggestions";
  static const String track = "track/";
  static const String withdrawal = "user/withdraw";
  static const String trackAnalysis = "analysis/track";
  static const String reaction = "reaction";
  static const String privacyPolicyKorean = "https://finutss.s3.ap-northeast-2.amazonaws.com/policy/9IECES_Privacy_Policy.ko.pdf";
  static const String termsOfServiceKorean = "https://finutss.s3.ap-northeast-2.amazonaws.com/policy/9IECES_Terms_of_service.ko.pdf";
  static const String privacyPolicyEnglish = "https://finutss.s3.ap-northeast-2.amazonaws.com/policy/9IECES_Privacy_Policy.en.pdf";
  static const String termsOfServiceEnglish = "https://finutss.s3.ap-northeast-2.amazonaws.com/policy/9IECES_Terms_of_service.en.pdf";
  static const String newsOfEvent = "news";
  static const String dashboard = "user/mobile/dashboard";
  static const String trackListing = "track/listing";
  static const String channelInfo = "channel/";
  static const String faq = "faq";
  static const String getNotice = "notice";
  static const String getLiveUser = "record/";
  static const String recommendedTrack = "track/recommendation";
  static const String getInquiryHistory = "inquiry";
  static const String putInquiryHistory = "inquiry/";
  static const String postInquiryHistory = "inquiry/";
  static const String notification = "notification";
  static const String verification = "user/verify/email";
  static const String resendOtp = "user/verify/email/resend";
  static const String followDetails = "follow/details";
  static const String sentInvitation = "track/invite";
  static const String buyEPSubscription = "wallet";
  static const String walletTransaction = "wallet/transaction";
  static const String dashboardImage = "https://finutss.s3.ap-northeast-2.amazonaws.com/Banner/Banners_custom_by_mk.json";
  static const String getTimeZone = "http://ip-api.com/json";

  static String getParamsFromBody(Map<String, dynamic>? body) {
    String params = '?';
    for (var i = 0; i < body!.keys.length; i++) {
      params += '${List.from(body.keys)[i]}=${List.from(body.values)[i]}';
      if (i != body.keys.length - 1) {
        params += '&';
      }
    }
    log(params);
    return params;
  }
}



