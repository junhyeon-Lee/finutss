import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MarketingInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(text: 'Receiving Marketing Info') as PreferredSizeWidget?,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 13.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customText(
                    text: 'June 10, 2021',
                    fontColor: Color(0xff7F8391),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Color(0xff7F8391),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: customText(
                  text: 'Receiving Marketing Info',
                  fontColor: Color(0xff303443),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 2,
              color: Color(0xffCDD5E9),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      style: TextStyle(
                        height: 2,
                        color: Color(0xff7F8391),
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "Would you like to receive information such as event and benefit guidance from Finutss? According to Article 22(4) of the Privacy Act, you may use the service without having to agree to the optional information.",
                        ),
                        TextSpan(
                          text:
                              '\n\n[Purpose for personal information collection] Offer discount coupons, provide benefit information, guide events, personalize services, use of marketing and advertising',
                        ),
                        TextSpan(
                          text:
                              "\n\n[Personal Information Collection Entries] Mobile number, Email",
                        ),
                        TextSpan(
                          text:
                              '\n\n[Holding Period] From the date of consent to the withdrawal of membership or withdrawal of consent;',
                        ),
                        TextSpan(
                          text:
                              '\n\nPlease agree to use marketing to receive advertising information such as events, services, and affiliated services provided by Peanuts.',
                        ),
                        TextSpan(
                          text:
                              "\n\n[Purpose of Collection] Offer discount coupons, benefit information, event notifications and opportunities to participate, personal and customized services, marketing and advertising, etc.",
                        ),
                        TextSpan(
                          text:
                              "\n\n[Collection Usage] Name, mobile number, Email",
                        ),
                        TextSpan(
                          text:
                              "\n\n[Holding Period] Until withdrawal of membership or withdrawal of",
                        ),
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
