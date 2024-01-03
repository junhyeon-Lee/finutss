import 'package:finutss/data/graphql_operation/queries/ReportQueries.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/presentation/screens/workout_screens/declare_type_details_screen.dart';
import 'package:finutss/presentation/widgets/dialogs/send_report.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeclareReportController extends GetxController {
  /* ---------------------------------- variables ---------------------------------- */
  bool isViolentThreats = false;
  bool isHarassment = false;
  bool isIdentityThief = false;
  bool isSpam = false;
  bool isPrivacyInfringement = false;
  bool isNotApplicable = false;
  var userInfo;

  /* -------------------------- TextEditingController ------------------------- */
  TextEditingController declareTypeTextController = TextEditingController();

/* -------------------------------- functions ------------------------------- */
  onViolentThreatsPressed() {
    isViolentThreats = !isViolentThreats;
    if (isViolentThreats) {
      isHarassment = false;
      isIdentityThief = false;
      isSpam = false;
      isPrivacyInfringement = false;
      isNotApplicable = false;
    }
    update();
  }

  onHarassmentPressed() {
    isHarassment = !isHarassment;
    if (isHarassment) {
      isViolentThreats = false;
      isIdentityThief = false;
      isSpam = false;
      isPrivacyInfringement = false;
      isNotApplicable = false;
    }
    update();
  }

  onIdentityPressed() {
    isIdentityThief = !isIdentityThief;
    if (isIdentityThief) {
      isHarassment = false;
      isViolentThreats = false;
      isSpam = false;
      isPrivacyInfringement = false;
      isNotApplicable = false;
    }
    update();
  }

  onSpamPressed() {
    isSpam = !isSpam;
    if (isSpam) {
      isHarassment = false;
      isIdentityThief = false;
      isViolentThreats = false;
      isPrivacyInfringement = false;
      isNotApplicable = false;
    }
    update();
  }

  onPrivacyPressed() {
    isPrivacyInfringement = !isPrivacyInfringement;
    if (isPrivacyInfringement) {
      isHarassment = false;
      isIdentityThief = false;
      isSpam = false;
      isViolentThreats = false;
      isNotApplicable = false;
    }
    update();
  }

  onNotApplicablePressed() {
    isNotApplicable = !isNotApplicable;
    if (isNotApplicable) {
      isHarassment = false;
      isIdentityThief = false;
      isSpam = false;
      isPrivacyInfringement = false;
      isViolentThreats = false;
    }
    update();
  }

  onDeclareCategoryButtonPressed() {
    if (isViolentThreats ||
        isHarassment ||
        isIdentityThief ||
        isSpam ||
        isPrivacyInfringement ||
        isNotApplicable) {
      Get.to(() => DeclareTypeDetailsScreen());
    } else
      print('select one');
  }

  onDeclareTypeButtonPressed() {
    var subCategory = "";

    if (isHarassment) subCategory = "Harassment";
    if (isIdentityThief) subCategory = "Identify thef";
    if (isSpam) subCategory = "Spam and Fraud";
    if (isPrivacyInfringement) subCategory = "Privacy Infringemnt";
    if (isViolentThreats) subCategory = "Violent Theats";
    if (isNotApplicable) subCategory = "Not applicable";

    GlobalBloc().queryMutate(ReportQueries.ADD_REPORT, {
      'data': {
        'name': '${userInfo['nickName']}를 신고 합니다.',
        'category': "Report",
        'subCategory': subCategory,
        'content': declareTypeTextController.text,
        'targetId': userInfo['id'],
      }
    });
    declareTypeTextController.clear();
    Get.dialog(SendReport());
  }
}
