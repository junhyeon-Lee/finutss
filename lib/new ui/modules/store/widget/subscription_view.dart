import 'package:finutss/new%20ui/in_app_purchase_service/app_purchase_service.dart';
import 'package:finutss/new%20ui/modules/store/controller/store_controller.dart';
import 'package:finutss/new%20ui/modules/store/widget/title_description.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class SubscriptionView extends StatelessWidget {
  SubscriptionView({Key? key}) : super(key: key);

  final StoreController controller = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleDescription(
          title: 'STORE_FINUTSS_SUBSCRIPTION',
          description: 'STORE_YOU_CAN_USE_ALL_THE_CONTENTS_OF_FINUTSS_UNLIMITEDLY',
        ),
        Obx(() => ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 14.h,bottom: 7.h),
            itemBuilder: (context, i) {
              return Obx(() => InkWell(
                onTap: (){
                  if(controller.selectedIndex.value==i){
                    controller.selectedIndex.value=-1;
                  }else{
                    controller.selectedIndex.value=i;
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.w)),
                      color: AppColor.whiteColor
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(controller.selectedIndex.value==i ? 10.w : 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.w)),
                          gradient: (i % 2 == 0)
                              ? LinearGradient(
                              colors: [
                                Color(0xFFF55DA3),
                                Color(0xFFDA68D0),
                                Color(0xFFB673FF),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              stops: [0.0, 0.4, 1.0],
                              tileMode: TileMode.repeated)
                              : LinearGradient(
                              colors: [
                                Color(0xFF85C4BF),
                                Color(0xFF72BEB7),
                                Color(0xFF55B0A6),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 0.4, 1.0],
                              tileMode: TileMode.clamp),

                          boxShadow: [
                            BoxShadow(
                              color: AppColor.cardGradiant1.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 13.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'STORE_FINUTSS_SUBSCRIPTION'.tr,
                                              style: TextStyle(
                                                color: AppColor.whiteColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            // Text(
                                            //   controller.storeList[i].title.tr,
                                            //   style: TextStyle(
                                            //     color: AppColor.whiteColor,
                                            //     fontWeight: FontWeight.w700,
                                            //     fontSize: 16.sp,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),


                                      Row(
                                        children: [
                                          Image.asset(
                                            IconAssets.calendar_tick,
                                            color: AppColor.whiteColor,
                                            width: 23.w,
                                          ),
                                          SizedBox(
                                            width: 7.w,
                                          ),
                                          Text(
                                            controller.storeList[i].totalMonth.tr,
                                            style: TextStyle(
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    controller.storeList[i].description.tr,
                                    style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Flexible(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(50.w)),
                                              color: AppColor.whiteColor.withOpacity(0.15)),
                                          padding : EdgeInsets.symmetric(vertical: 5.3.h,horizontal: 9.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                IconAssets.discount,
                                                color: AppColor.whiteColor,
                                                height: 19.h,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  controller.storeList[i].discount.tr,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: AppColor.whiteColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),



                                      Text(
                                        controller.storeList[i].amount,
                                        style: TextStyle(
                                          color: AppColor.whiteColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 19.sp,
                                          letterSpacing: 0.2
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      controller.selectedIndex.value==i ? Padding(
                        padding: EdgeInsets.only(left: 22.w,right:22.w,top: 5.h,bottom: 14.h),
                        child: Column(
                          children: [
                            ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context,index){
                              return Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: AppColor.subTitleColor,
                                    size: 15.w,
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.storeList[i].itemList[index].title.tr,
                                      style: TextStyle(
                                        color:  controller.storeList[i].itemList[index].isFree ? AppColor.orangeColor : AppColor.subTitleColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }, separatorBuilder: (context,i){
                              return SizedBox(
                                height: 8.h,
                              );
                            }, itemCount: controller.storeList[i].itemList.length),

                            SizedBox(
                              height: 14.h,
                            ),
                            CustomSliderButton(
                              height: 46.w,
                              title: controller.storeList[i].btnTitle.tr,
                              onTap: () {
                                PaymentService().buySubscription(controller.storeList[i].purchaseId);
                                //InAppPurchasePaymentService().buy(productID: controller.storeList[i].purchaseId);
                              },
                              isCancelButton: false,
                            )
                          ],
                        ),
                      ): SizedBox(),
                    ],
                  ),
                ),
              ));
            },
            separatorBuilder: (context, i) {
              return SizedBox(
                height: 14.h,
              );
            },
            itemCount: controller.storeList.length)),
      ],
    );
  }
}
