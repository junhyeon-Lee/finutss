import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/data/models/wear_position_model.dart';
import 'package:finutss/domain/controller/edit_body_info_controller.dart';
import 'package:finutss/domain/controller/sensor_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:finutss/presentation/widgets/dialogs/sensor_dialogs/exerciser_dialog.dart';
import 'package:finutss/presentation/widgets/dialogs/sensor_dialogs/stride_test_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MobileDeviceDialog extends StatefulWidget {
  @override
  _MobileDeviceDialogState createState() => _MobileDeviceDialogState();
}

class _MobileDeviceDialogState extends State<MobileDeviceDialog>
    with SingleTickerProviderStateMixin {
  bool _large = false;
  bool _strideTestRetry = false;
  bool _selectPosition = false;

  void _updateSize() {
    setState(() {
      _large = !_large;
    });
  }

  final editBodyInfoController = Get.put(EditBodyInfoController());
  RxList<ChipsModel> bookMarkFilterChipsList = <ChipsModel>[].obs;

  @override
  void initState() {
    // TODO: implement initState
    bookMarkFilterChipsList.value = [
      ChipsModel(
        text: "Hand",
        isSelected: false.obs,
        description: 'Holding the device in hand',
        imagePath:
            'https://w7.pngwing.com/pngs/612/466/png-transparent-wearable-technology-wearable-computer-smartwatch-logo-electronics-band-miscellaneous-text-hand-thumbnail.png',
      ),
      ChipsModel(
        text: "Pocket",
        isSelected: false.obs,
        description: 'Device in your pocket',
      ),
      ChipsModel(
        text: "Arm",
        isSelected: false.obs,
        description: 'DEVICE_WITH_AN_ARMBAND'.tr,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SensorController>(
      builder: (controller) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          contentPadding: EdgeInsets.zero,
          insetPadding:
              EdgeInsets.only(right: 16.w, left: 16.w, top: 50.h, bottom: 60.h),
          backgroundColor: Colors.white,
          content: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* --------------------------------- heading -------------------------------- */
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(child: headingWidget(title: 'CONNECTION'.tr)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        backgroundColor: colorBackgroundSilver,
                        radius: 20.r,
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              CommunityMaterialIcons.window_close,
                              size: 24.r,
                              color: colorDarkGrey,
                            )),
                      ),
                    ),
                  ],
                ),
                size5,
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          subHeadingWidget(title: "Mobile Device"),
                          // Spacer(),
                          customButton(
                            onTapFunction: () {
                              Get.back();
                              Get.dialog(ExerciserDialog(),
                                  barrierDismissible: false);
                            },
                            text: 'EXERCISER_CHANGE'.tr,
                            width: 100,
                            height: 35,
                            textSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            borderColor: Colors.black,
                            textColor: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _wearPosition(),
                              _bodyInfo(),
                              _strideTest(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _wearPosition() {
    return commonDevice('Wear position',
        "Choose the wear position of your mobile device.", "Choose", true, () {
      _updateSize();
    }, false);
  }

  Widget _bodyInfo() {
    return commonDevice(
        'Body Info', "No body information yet.", "Body Info", false, () {
      editBodyInfoController.onEditBodyInfoIconPressed();
    }, false, bodyEditEnable: true);
  }

  Widget _strideTest() {
    return commonDevice(
        'STRIDE_TEST'.tr,
        "Measures the value of movement along the stride length",
        "Test",
        false, () {
      Get.dialog(StrideTestDialog(), barrierDismissible: false).then((value) {
        print("abc---->$value");
        return value == null ? false : _strideTestRetry = value['result'];
      });
    }, true);
  }

  Widget commonDevice(
      String headingText,
      String description,
      String buttonText,
      bool isShowWearPositionItems,
      VoidCallback buttonOnTap,
      bool showTriddeChaneg,
      {bool bodyEditEnable = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          border: Border.all(
            color: colorLightSilver,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(headingText,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w600)),
                  CircleAvatar(
                    backgroundColor: colorBackgroundSilver,
                    radius: 16.r,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          CommunityMaterialIcons.check,
                          size: 20.r,
                          color: _selectPosition && isShowWearPositionItems
                              ? Colors.green
                              : editBodyInfoController
                                          .isCompletedBodyInfo.value &&
                                      bodyEditEnable
                                  ? Colors.green
                                  : colorWhitish,
                        )),
                  ),
                ],
              ),
              isShowWearPositionItems && _large
                  ? _selectPosition
                      ? itemsView([
                          bookMarkFilterChipsList.firstWhere(
                              (element) => element.isSelected?.value == true)
                        ], 0)
                      : _wearPositionItems()
                  : editBodyInfoController.isCompletedBodyInfo.value &&
                          bodyEditEnable
                      ? bodyStrideEditView(
                          'Body information is registered',
                          () {
                            editBodyInfoController.isCompletedBodyInfo.value =
                                !editBodyInfoController
                                    .isCompletedBodyInfo.value;
                          },
                          'Edit',
                        )
                      : showTriddeChaneg && _strideTestRetry
                          ? strideEditView(
                              'Test completed normally.',
                              () {
                                Get.dialog(StrideTestDialog(),
                                        barrierDismissible: false)
                                    .then((value) {
                                  print("abc---->$value");
                                  return value == null
                                      ? false
                                      : _strideTestRetry = value['result'];
                                });
                              },
                              'Retry',
                            )
                          : Container(
                              width: 282.w,
                              decoration: BoxDecoration(
                                color: colorBackgroundSilver,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 12,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      description,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: colorLightGrey),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    GestureDetector(
                                      onTap: buttonOnTap,
                                      child: Container(
                                        width: 120.w,
                                        height: 35.h,
                                        decoration: BoxDecoration(
                                          color: colorDarkGrey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            buttonText,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: colorWhite),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _wearPositionItems() {
    return Container(
      height: MediaQuery.of(context).size.height / 2.6,
      width: MediaQuery.of(context).size.width,
      child: Obx(
        () => ListView.builder(
          itemCount: bookMarkFilterChipsList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return itemsView(bookMarkFilterChipsList, index);
          },
        ),
      ),
    );
  }

  Widget itemsView(List<ChipsModel> bookMarkFilterChipsList, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: colorBackgroundSilver,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12,
          ),
          child: Row(
            children: [
              Expanded(
                  child: Image.network(
                      'https://en.pimg.jp/059/493/593/1/59493593.jpg')),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookMarkFilterChipsList[index].text ?? '',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: colorLightGrey),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        bookMarkFilterChipsList[index].description ?? '',
                        // "Holding the device in hand",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: colorLightGrey),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    bookMarkFilterChipsList[index].isSelected?.value =
                        !(bookMarkFilterChipsList[index].isSelected?.value ??
                            false);
                    _selectPosition = !_selectPosition;
                    setState(() {});
                  },
                  child: Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: colorLightSilver,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: Text(
                        (bookMarkFilterChipsList[index].isSelected?.value ??
                                false)
                            ? 'Edit'
                            : "Select",
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: colorDarkGrey),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyStrideEditView(String text, VoidCallback onTap, buttonTxt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: colorBackgroundSilver,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: colorLightGrey),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: colorLightSilver,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: Text(
                        buttonTxt,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: colorDarkGrey),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget strideEditView(String text, VoidCallback onTap, buttonTxt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: colorBackgroundSilver,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: colorLightGrey),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: colorLightSilver,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: Text(
                        buttonTxt,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: colorDarkGrey),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
