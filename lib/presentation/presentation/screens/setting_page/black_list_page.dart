import 'package:finutss/domain/controller/black_list_controller.dart';
import 'package:finutss/domain/controller/dummy_data_controller.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/live_user_widgets/live_user_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlackListPage extends StatelessWidget {
  final DummyDataController dummyDataController = Get.put(DummyDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(text: 'BLACKLIST'.tr) as PreferredSizeWidget?,
      body: SingleChildScrollView(child: buildBlackList()),
    );
  }
}

class buildBlackList extends StatelessWidget {
  var isDatePrint = false;
  var tempDay = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<BlockListController>(builder: (controller) {
      return Container(
        width: double.infinity,
        height: height,
        child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: controller.blockList?.length ?? 0,
            itemBuilder: (context, index) {
              print(controller.blockList[index]);
              var itemDay = DateTime.parse(controller.blockList[index]['createdAt']).day;
              if (itemDay > tempDay) {
                tempDay = itemDay;
                isDatePrint = true;
              } else {
                isDatePrint = false;
              }
              return Column(
                children: [
                  if (isDatePrint)
                    Column(
                      children: [dateView(controller.blockList[index]['createdAt']), size10],
                    ),
                  liveUserCard(
                      backgroundColor: colorBackgroundSilver,
                      isBlackList: true,
                      isBottomSheet: true,
                      userInfo: controller.blockList[index]["targetId"]),
                ],
              );
            }),
      );
    });
  }
}

Widget dateView(itemDate) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      customText(
        text: LocalDB.convertDateFormat(itemDate, 'yyyy-MM-dd'),
        fontColor: colorWhitish,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      )
    ],
  );
}
