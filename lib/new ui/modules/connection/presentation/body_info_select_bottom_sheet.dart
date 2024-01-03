import 'package:finutss/new%20ui/modules/connection/presentation/body_imformation_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/gender_selection_screen.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/height_selection_screen.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/weight_screen.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/year_of_birth.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> bodyInfoSelectBottomSheet({
  required BuildContext context,
  int index = 0,
  int itemIndex = 1,
  bool? isPopValue,
  bool? isBack,
}) {
  RxInt currentIndex = index.obs;

  PageController pageController =
      PageController(initialPage: currentIndex.value);
  final BmiSliderController controller = Get.find();

  List<Widget> pageViewList = [
    GenderSelectionScreen(),
    YearOfBirthScreen(),
    HeightSelectionScreen(),
    WeightSelectionScreen(),
    BodyInformationScreen(),
  ];

  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    enableDrag: false,
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            CloseButtonCustom(
              onTap: () {
                Get.back();
              },
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(
                            MediaQuery.of(context).size.width,
                            100.0,
                          ),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.w,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 26.h,
                          ),
                          Expanded(
                            child: PageView.builder(
                              controller: pageController,
                              itemCount: pageViewList.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return pageViewList[index];
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Obx(
                            () {
                              int listLength = pageViewList.length - 1;
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: Row(
                                  children: [
                                    CustomSliderButton(
                                      height: 48.w,
                                      title: '',
                                      onTap: () {
                                        if (currentIndex != -1) {
                                          currentIndex.value =
                                              currentIndex.value - 1;
                                          pageController.animateToPage(
                                              currentIndex.value,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              curve: Curves.linearToEaseOut);
                                        } else {
                                          Navigation.pop();
                                        }
                                      },
                                      isCancelButton: true,
                                      width: 54.w,
                                    ),
                                    SizedBox(
                                      width: 26.w,
                                    ),
                                    Expanded(
                                      child: CustomSliderButton(
                                        height: 48.w,
                                        title: listLength == currentIndex.value
                                            ? 'SAVE'.tr
                                            : 'NEXT'.tr,
                                        onTap: () {
                                          if (listLength !=
                                              currentIndex.value) {
                                            controller.calculateBMI();
                                            currentIndex.value =
                                                currentIndex.value + 1;
                                            pageController.animateToPage(
                                                currentIndex.value,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.ease);
                                            // controller.updateBodyInfo();
                                          } else {
                                            /*if(is2Back){
                                                Navigation.pop();
                                              }*/

                                            Constants
                                                .positionModelList[itemIndex]
                                                .isSelected
                                                .value = true;

                                            if (!Constants.isGuest) {
                                              controller.updateBodyInfo(isBack ?? false);
                                            } else {
                                              Navigation.pop();
                                            }
                                          }
                                        },
                                        isCancelButton: false,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 34.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
