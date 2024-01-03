import 'package:finutss/new%20ui/modules/live%20user/presentation/follow_user_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/map_view/model/chat_message_model.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatMessageView extends StatelessWidget {
  ChatMessageView({Key? key,required this.chatModel,required this.currentUserId}) : super(key: key);

  Rows chatModel;
  String currentUserId;
  String? time;

  @override
  Widget build(BuildContext context) {
    time=DateFormat('hh:mm aa')
        .format(DateTime.parse(chatModel.createdAt ?? '2022-12-06T05:34:42.000Z').toLocal())
        .toString();

    if(time!=null){
      time=Constants.removeAmPm(time??'');
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        chatModel.userId!=currentUserId ?  InkWell(
          onTap: (){
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) => FollowBottomSheet(
                  userId: chatModel.user?.id ?? '',
                  index: -1,
                ),
              ),
            );
          },
          child: CustomCircleImageview(
            width: 38.w,
            imagePath: chatModel.user?.profilePhoto ?? '',
          ),
        ) : SizedBox(),

        SizedBox(
          width: 10.w,
        ),

        Expanded(child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: chatModel.userId==currentUserId ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [


            chatModel.userId==currentUserId ? Row(
              children: [

                SizedBox(width: 40.w,),
                Text(
                  time ?? '',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                    color: AppColor.blue,
                  ),
                ),
                SizedBox(width: 8.w,),
              ],
            ) : SizedBox(),

          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:  chatModel.userId!=currentUserId ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                chatModel.userId!=currentUserId ? Text(
                  chatModel.user?.username ?? '',
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                    letterSpacing: 0.1,
                  ),
                ) : SizedBox(),

                SizedBox(
                  height: 8,
                ),



                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.5.h,horizontal: 14.w),
                  margin: EdgeInsets.only(right: chatModel.userId!=currentUserId ? 8.w : 0),
                  decoration: BoxDecoration(
                      color: chatModel.userId==currentUserId ? AppColor.blue : chatModel.userId!=currentUserId ? AppColor.whiteColor : AppColor.orangeColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.w))
                  ),
                  child: Text(
                    chatModel.content ?? '',
                    maxLines: 10,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                      color: chatModel.userId==currentUserId ? AppColor.whiteColor.withOpacity(0.8) : AppColor.chatTextColor.withOpacity(0.7),
                    ),
                  ),
                ),




              ],
            ),
          ),

          chatModel.userId!=currentUserId ? Text(
            time ?? '',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.2,
              color:AppColor.whiteColor.withOpacity(0.8),
            ),
          ) : SizedBox(),
        ],),),

      ],
    );
  }
}
