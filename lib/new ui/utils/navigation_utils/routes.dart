import 'package:finutss/new%20ui/modules/app_permission/presentation/app_permission_screen.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/app_permissions_screen.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/blacklist_screen.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/faq_screen.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/intialize-app_data_screen.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/language_screen.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/my_page.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/myscreen_change_password_screen.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/payment_info.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/push_notification_screen.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/sound_screen.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/withdrawal_approve_screen.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/withdrawal_reason_screen.dart';
import 'package:finutss/new%20ui/modules/app_setting/presentation/withdrawal_screen.dart';
import 'package:finutss/new%20ui/modules/change_password/presentation/change_password_screen.dart';
import 'package:finutss/new%20ui/modules/change_password/presentation/change_password_with_otp.dart';
import 'package:finutss/new%20ui/modules/change_password/presentation/create_password_screen.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/speed_celibration_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/stride_test_screen.dart';
import 'package:finutss/new%20ui/modules/contact_us/presentation/contact_us_screen.dart';
import 'package:finutss/new%20ui/modules/contact_us/presentation/inquiry_history_screen.dart';
import 'package:finutss/new%20ui/modules/dash_board_bottom_navi/presentation/dash_bord_screen.dart';
import 'package:finutss/new%20ui/modules/event/presentation/event_screen.dart';
import 'package:finutss/new%20ui/modules/history/history_screen.dart';
import 'package:finutss/new%20ui/modules/home/presentation/home_screen.dart';
import 'package:finutss/new%20ui/modules/map_view/presentation/chat_screen.dart';
import 'package:finutss/new%20ui/modules/nick_name_screen/nick_name_screen.dart';
import 'package:finutss/new%20ui/modules/notice/presentation/notice_screen.dart';
import 'package:finutss/new%20ui/modules/on_boarding/presentation/on_boarding_screen.dart';
import 'package:finutss/new%20ui/modules/profile/presentation/profile_screen.dart';
import 'package:finutss/new%20ui/modules/record/presentation/track_body_info.dart';
import 'package:finutss/new%20ui/modules/report_screen/presentation/report_details_screen.dart';
import 'package:finutss/new%20ui/modules/sign_in/presentation/sign_in_screen.dart';
import 'package:finutss/new%20ui/modules/sign_in/presentation/social_login_screen_new.dart';
import 'package:finutss/new%20ui/modules/sign_in/presentation/verification_screen.dart';
import 'package:finutss/new%20ui/modules/sign_up/presentation/sign_up_screen.dart';
import 'package:finutss/new%20ui/modules/social/presentation/find_friends_screen.dart';
import 'package:finutss/new%20ui/modules/splash/presentation/fintuss_splash_screen.dart';
import 'package:finutss/new%20ui/modules/splash/presentation/splash_screen.dart';
import 'package:finutss/new%20ui/modules/store/presentation/store.dart';
import 'package:finutss/new%20ui/modules/subcription/presentation/coupon_code_registration_screen.dart';
import 'package:finutss/new%20ui/modules/subcription/presentation/coupon_registration_screen.dart';
import 'package:finutss/new%20ui/modules/subcription/presentation/recepit_screen.dart';
import 'package:finutss/new%20ui/modules/subcription/presentation/subcription_info_screen.dart';
import 'package:finutss/new%20ui/modules/subcription/presentation/unsubscribe_history_screen.dart';
import 'package:finutss/new%20ui/modules/subcription/presentation/unsubscribe_reason_screen.dart';
import 'package:finutss/new%20ui/modules/subcription/presentation/unsubscription_payment_screen.dart';
import 'package:finutss/new%20ui/modules/termsAgree/presentation/terms_agree_screen.dart';
import 'package:finutss/new%20ui/modules/track/presentation/most_popular_view_all_screen.dart';
import 'package:finutss/new%20ui/modules/user_guide/presentation/body_info_guide_screen.dart';
import 'package:finutss/new%20ui/modules/user_guide/presentation/record_guide_screen.dart';
import 'package:finutss/new%20ui/modules/user_guide/presentation/sensor_slider_screen.dart';
import 'package:finutss/new%20ui/modules/user_guide/presentation/user_guide_screen.dart';
import 'package:finutss/new%20ui/modules/user_guide/presentation/workout_guide_screen.dart';
import 'package:finutss/new%20ui/modules/welcome_screen/welcome_screen.dart';
import 'package:get/get.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;
  static const String fintussSplash = '/FintussSplashScreen';
  static const String splash = '/splash';
  static const String appPermissionScreen = '/AppPermissionScreen';
  static const String onBoardingScreen = '/OnBoardingScreen';
  static const String dashboardScreen = '/dashboardScreen';
  static const String homeScreen = '/homeScreen';
  static const String tabBar = '/tabBar';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String socialLoginScreen = '/SocialLoginScreenNew';
  static const String changePassword = '/ChangePasswordScreen';
  static const String changePasswordWithOTP = '/ChangePasswordWithOTP';
  static const String createPassword = '/CreatePasswordScreen';
  static const String termsAgreeScreen = '/termsAgreeScreen';
  static const String nickNameScreen = '/nickNameScreen';
  static const String welcomeScreen = '/welcomeScreen';
  static const String sensorSliderScreen = '/sensorSliderScreen';
  static const String mostPopularViewAllScreen = '/mostPopularViewAllScreen';
  static const String userProfileScreen = '/UserProfileScreen';
  static const String myPageScreen = '/MyPageScreen';
  static const String noticeScreen = '/NoticeScreen';
  static const String eventScreen = '/EventScreen';
  static const String contactUsScreen = '/ContactUsScreen';
  static const String inquiryHistoryScreen = '/InquiryHistoryScreen';
  static const String initializeAppDataScreen = '/InitializeAppDataScreen';
  static const String subscriptionInoScreen = '/SubscriptionInfoScreen';
  static const String unSubscriptionPaymentScreen =
      '/UnSubscriptionPaymentScreen';
  static const String receiptScreen = '/ReceiptScreen';
  static const String myScreenChangePasswordScreen =
      '/MyScreenChangePasswordScreen';
  static const String blackListScreen = '/BlackListScreen';
  static const String findFriendsScreen = '/FindFriendsScreen';
  static const String unSubscribeHistoryScreen = '/UnSubscribeHistoryScreen';
  static const String withdrawalScreen = '/WithdrawalScreen';
  static const String paymentInfoScreen = '/PaymentInfoScreen';
  static const String couponRegistrationScreen = '/CouponRegistrationScreen';
  static const String historyScreen = '/HistoryScreen';
  static const String profileScreen = '/ProfileScreen';
  static const String userGuideScreen = '/UserGuideScreen';
  static const String withdrawalApproveScreen = '/WithdrawalApproveScreen';
  static const String reportDetailScreen = '/ReportDetailsScreen';
  static const String withdrawalReasonScreen = '/WithdrawalReasonScreen';
  static const String unSubscribeReasonScreen = '/UnSubscribeReasonScreen';
  static const String languageScreen = '/LanguageScreen';
  static const String soundScreen = '/SoundScreen';
  static const String appPermissionsScreen = '/AppPermissionsScreen';
  static const String pushNotificationScreen = '/PushNotificationScreen';
  static const String workoutGuideScreen = '/WorkoutGuideScreen';
  static const String bodyInfoGuideScreen = '/BodyInfoGuideScreen';
  static const String recordGuideScreen = '/RecordGuideScreen';
  static const String storeScreen = '/StoreScreen';
  static const String trackBodyInfoScreen = '/TrackBodyInfo';
  static const String couponCodeRegistrationScreen =
      '/CouponCodeRegistrationScreen';
  static const String trackScreen = '/TrackScreen';
  static const String faqScreen = '/FaqScreen';
  static const String chatScreen = '/ChatScreen';
  static const String strideTestScreen = '/strideTestScreen';
  static const String verificationScreen = '/verificationScreen';
  static const String speedCalibration = '/speedCalibrationBottomSheet';
  static bool isAdminArgument = false;

  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: splash,
      page: () => SplashScreenNew(),
      transition: Transition.fade,
    ),
    GetPage<dynamic>(
      name: dashboardScreen,
      page: () => DashboardScreen(),
      transition: Transition.fade,
    ),
    GetPage<dynamic>(
      name: homeScreen,
      page: () => HomeScreen(),
      transition: Transition.fade,
    ),
    GetPage<dynamic>(
      name: signIn,
      page: () => SignInScreen(),
      transition: Transition.fade,
    ),
    GetPage<dynamic>(
      name: signUp,
      page: () => SignUpScreen(),
      transition: Transition.fade,
    ),
    GetPage<dynamic>(
      name: termsAgreeScreen,
      page: () => TermsAgreeScreen(),
      transition: Transition.fade,
    ),
    GetPage<dynamic>(
      name: nickNameScreen,
      page: () => NickNameScreen(),
      transition: Transition.fade,
    ),
    GetPage<dynamic>(
      name: welcomeScreen,
      page: () => WelcomeScreen(),
      transition: Transition.fade,
    ),
    GetPage<dynamic>(
      name: sensorSliderScreen,
      page: () => SensorSliderScreen(),
      transition: Transition.fade,
    ),
    GetPage<dynamic>(
      name: mostPopularViewAllScreen,
      page: () => MostPopularViewAllScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: onBoardingScreen,
      page: () => OnBoardingScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: fintussSplash,
      page: () => FintussSplashScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: appPermissionScreen,
      page: () => AppPermissionScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: changePassword,
      page: () => ChangePasswordScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: changePasswordWithOTP,
      page: () => ChangePasswordWithOTP(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: createPassword,
      page: () => CreatePasswordScreen(),
      transition: defaultTransition,
    ),
    /* GetPage<dynamic>(
      name: userProfileScreen,
      page: () => UserProfileScreen(),
      transition: defaultTransition,
    ),*/
    GetPage<dynamic>(
      name: noticeScreen,
      page: () => NoticeScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: eventScreen,
      page: () => EventScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: contactUsScreen,
      page: () => ContactUsScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: inquiryHistoryScreen,
      page: () => InquiryHistoryScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: myScreenChangePasswordScreen,
      page: () => MyScreenChangePasswordScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: initializeAppDataScreen,
      page: () => InitializeAppDataScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: subscriptionInoScreen,
      page: () => SubscriptionInfoScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: receiptScreen,
      page: () => ReceiptScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: blackListScreen,
      page: () => BlackListScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: unSubscriptionPaymentScreen,
      page: () => UnSubscriptionPaymentScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: unSubscribeHistoryScreen,
      page: () => UnSubscribeHistoryScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: withdrawalScreen,
      page: () => WithdrawalScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: couponRegistrationScreen,
      page: () => CouponRegistrationScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: paymentInfoScreen,
      page: () => PaymentInfoScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: historyScreen,
      page: () => HistoryScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: withdrawalReasonScreen,
      page: () => WithdrawalReasonScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: profileScreen,
      page: () => ProfileScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: withdrawalApproveScreen,
      page: () => WithdrawalApproveScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: userGuideScreen,
      page: () => UserGuideScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: unSubscribeReasonScreen,
      page: () => UnSubscribeReasonScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: languageScreen,
      page: () => LanguageScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: soundScreen,
      page: () => SoundScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: appPermissionsScreen,
      page: () => AppPermissionsScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: pushNotificationScreen,
      page: () => PushNotificationScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: workoutGuideScreen,
      page: () => WorkoutGuideScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: bodyInfoGuideScreen,
      page: () => BodyInfoGuideScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: recordGuideScreen,
      page: () => RecordGuideScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: reportDetailScreen,
      page: () => ReportDetailsScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: storeScreen,
      page: () => StoreScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: trackBodyInfoScreen,
      page: () => TrackBodyInfo(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: couponCodeRegistrationScreen,
      page: () => CouponCodeRegistrationScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: findFriendsScreen,
      page: () => FindFriendsScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: faqScreen,
      page: () => FaqScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: strideTestScreen,
      page: () => StrideTestScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: myPageScreen,
      page: () => MyPageScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: socialLoginScreen,
      page: () => SocialLoginScreenNew(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: speedCalibration,
      page: () => speedCalibrationBottomSheet(),
      transition: defaultTransition,
    ),

    GetPage<dynamic>(
      name: verificationScreen,
      page: () => VerificationScreen(),
      transition: defaultTransition,
    ),
  ];
}
