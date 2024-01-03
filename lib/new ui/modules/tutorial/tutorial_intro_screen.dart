import 'package:finutss/new%20ui/modules/tutorial/picker_button.dart';
import 'package:finutss/new%20ui/modules/tutorial/tutorial_bot_chat.dart';
import 'package:finutss/new%20ui/modules/tutorial/tutorial_button.dart';
import 'package:finutss/new%20ui/modules/tutorial/tutorial_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TutorialIntroScreen extends StatelessWidget {
  const TutorialIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TutorialController controller = Get.find();
    ScrollController scrollController = ScrollController();
    return WillPopScope(
      onWillPop: () async{ return false; },
      child: GetBuilder<TutorialController>(builder: (controller){
        return Container(
          color: Colors.black.withOpacity(0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 35.h),

              Expanded(
                child: Container(
                  width: 375.w,
                  child: ListView.builder(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return controller.chat[index];
                      },itemCount: controller.chat.length),
                ),
              ),

              SizedBox(height: 35.h),

              controller.buttonIndex==0?
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(
                              WebView(
                                initialUrl: 'http://www.finutss.com/privacy_policy/',
                                javascriptMode: JavascriptMode.unrestricted,
                              )
                          );
                        },
                        child: WebButton(
                          title: '개인정보보호정책',
                        )),
                    SizedBox(height: 30.h,),
                    GestureDetector(
                        onTap: controller.isIntro?() {
                          controller.chatFlow('알겠어요',true);
                          Future.delayed(const Duration(seconds: 1),(){
                            controller.chatFlow('User name\n님의성별을 알려주세요..',false);
                            controller.nextButton();
                          });
                        }:null,
                        child: TutorialButton(title: '알겠어요')),

                  ],
                ),
              ):
              controller.buttonIndex==1?Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.chatFlow('여성이에요.',true);
                          Future.delayed(const Duration(seconds: 1),(){
                            controller.chatFlow('User name님의\n키를 알려주세요.',false);
                          });
                          controller.nextButton();
                        },
                        child: TutorialButton(title: '여성'
                        )),
                    SizedBox(height: 30.h,),
                    GestureDetector(
                        onTap: () {
                          controller.chatFlow('남성이에요.',true);
                          Future.delayed(const Duration(seconds: 1),(){
                            controller.chatFlow('User name님의\n키를 알려주세요.',false);
                          });
                          controller.nextButton();
                        },
                        child: TutorialButton(title: '남성')),

                  ],
                ),
              )
                  :controller.buttonIndex==2?HeightPicker()
                  : WeightPicker()


            ],
          ),
        );
      }),
    );


  }
}

class WebButton extends StatelessWidget {
  const WebButton({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Color(0xffff8c41), width: 1.5)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              IconAssets.WebLinkIcon,
              color: AppColor.orangeColor,
              width: 25.w,
              height: 25,
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(width: 25.w,)
          ],
        ),
      ),
    );
  }
}



