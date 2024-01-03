import 'package:finutss/presentation/screens/introductory_screens/introductory_carousal_screen.dart';
import 'package:finutss/domain/bloc/permissions_info_bloc/permissions_info_bloc.dart';
import 'package:finutss/domain/bloc/permissions_info_bloc/permissions_info_event.dart';
import 'package:finutss/domain/bloc/permissions_info_bloc/permissions_info_state.dart';
import 'package:finutss/presentation/screens/signup_screens/permissions_info_screen/widgets/permissions_info_widget.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/default_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finutss/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PermissionsInfoScreen extends StatefulWidget {
  PermissionsInfoScreen() : super();

  @override
  _AppPermissionsInfoScreen createState() => _AppPermissionsInfoScreen();
}

class _AppPermissionsInfoScreen extends State<PermissionsInfoScreen> {
  late PermissionsInfoBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PermissionsInfoBloc>(context);
    bloc.add(PermissionsInfoGetPermission());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocConsumer<PermissionsInfoBloc, PermissionsInfoState>(
        builder: (context, state) {
          return permissions(context);
        },
        listener: (context, state) {
          if(state is PermissionsInfoShowDialogPermission) {
            checkPermission();
          }

          if(state is PermissionsInfoIntroductoryScreen) {
            Get.off(() => IntroductoryScreen());
          }
        },
      ),
    );
  }

  void checkPermission() async {
    Get.dialog(DefalutDialog(
        title: "Notice",
        description: """If you don't allow Bluetooth connection, you can't use the normal service.
          Please activate the Bluetooth authority.""",
        buttons: Row(
          children: [
            Expanded(
              child: customButton(
                  onTapFunction: () {
                    Get.off(() => IntroductoryScreen());
                  },
                  borderColor: colorDarkGrey,
                  radius: 16,
                  height: 48,
                  text: 'Close',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textColor: colorDarkGrey,
                  textSize: 16),
            ),
            size5,
            Expanded(
              child: customButton(
                  onTapFunction: () {
                    openAppSettings();
                    Get.back();
                  },
                  radius: 16,
                  height: 48,
                  text: 'Setting',
                  fontWeight: FontWeight.bold,
                  color: colorPink,
                  textColor: Colors.white,
                  textSize: 16),
            ),
          ],
        )
    ));
  }
}
