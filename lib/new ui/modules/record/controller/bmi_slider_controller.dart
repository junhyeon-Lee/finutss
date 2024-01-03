import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/helper/toast_helper.dart';
import 'package:finutss/new%20ui/modules/profile/service/update_profile_service.dart';
import 'package:finutss/new%20ui/modules/record/model/body_record_model.dart';
import 'package:finutss/new%20ui/modules/record/service/user_service.dart';
import 'package:finutss/new%20ui/modules/record/service/weight_record_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class BmiSliderController extends GetxController {
  RxBool male = false.obs;
  RxBool female = false.obs;
  String selectGender = Constants.FEMALE;
  String selectHeight = '100';
  String selectWeight = '30';
  String selectYearOfBirth = '2021';
  String createdDate = '';
  String todayDate = '';

  RxList<WeightRecordArray> bodyInfoDataList = RxList([]);
  DateFormat dateFormat = DateFormat("MM.dd");
  DateFormat dateTime = DateFormat('dd/MM/yyyy');
  RxInt bmiValue = 0.obs;
  Rx<LoginModel> userModel = LoginModel().obs;
  var userBMI = 0.0;
  double bmiBarWidth = 0;

  List<int> yearList = [
    2021,
    2020,
    2019,
    2018,
    2017,
    2016,
    2015,
    2014,
    2013,
    2012,
    2011,
    2010,
    2009,
    2008,
    2007,
    2006,
    2005,
    2004,
    2003,
    2002,
    2001,
    2000,
    1999,
    1998,
    1997,
    1996,
    1995,
    1994,
    1993,
    1992,
    1991,
    1990,
    1989,
    1988,
    1987,
    1986,
    1985,
    1984,
    1983,
    1982,
    1981,
    1980,
    1979,
    1978,
    1977,
    1976,
    1975,
    1974,
    1973,
    1972,
    1971,
    1970,
    1969,
    1968,
    1967,
    1966,
    1965,
    1964,
    1963,
    1962,
    1961,
    1960,
    1959,
    1958,
    1957,
    1956,
    1955,
    1954,
    1953,
    1952,
    1951,
    1950,
    1949,
    1948,
    1947,
    1946,
    1945,
    1943,
    1941,
    1939,
    1937,
    1935,
    1933,
    1930,
    1929,
    1928,
    1927,
    1926,
    1925,
    1924,
    1923,
    1922,
    1921,
    1920,
    1919,
    1918,
    1917,
    1916,
    1915,
    1914,
    1913,
    1912,
    1911,
    1910,
    1909,
    1909,
    1908,
    1907,
    1906,
    1905,
    1904,
    1903,
    1902,
    1901,
    1900,
  ];
  RxInt selectIndexYear = 0.obs;
  int differenceInDays = 0;
  RxString daysTitle = 'WEIGHT_CHANGE_RECOMMENDATION'.tr.obs;

  final List<int> heightList = List<int>.generate(150, (i) => i + 100);
  RxInt selectIndexHeight = 0.obs;

  final List<int> weightList = List<int>.generate(271, (i) => i + 30);
  final RxInt selectIndexWeight = 0.obs;

  RxDouble bmi = 0.0.obs;
  double scaleBmiValue = 0;
  double bmiSliderValue = 0;

  setBMIBarWidth(double value) {
    bmiBarWidth = (value - 20);
    update();
  }

  calculateBMI() {
    bmi.value = (int.parse(selectWeight) /
            int.parse(selectHeight) /
            int.parse(selectHeight)) *
        10000;
    calculateBmiSliderValue();
    // bmiValue =
    update();
  }

  calculateBmiSliderValue() {
    scaleBmiValue = bmi.value - 15;
    bmiSliderValue = (scaleBmiValue * 250) / 25;
    print(bmiSliderValue);
    update();
  }

  Future updateBodyInfo(bool isBack) async {
    AppLoader(Get.context!);
    try {

      LoginModel? model = await updateProfile();
      if (model?.statusCode == Constants.successCode200) {
        Navigation.pop();
        getUserInfo();
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      Navigation.pop();
      if (isBack) {
        Navigation.pop();
      }
    }
  }


  Future<LoginModel?> updateProfile() async {
    AppLoader(Get.context!);
    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(ApiConstants.baseUrl+ ApiConstants.editProfile),
      );

      Map<String, String> headers = {
        "Authorization": await SharedPrefs.getToken(),
        "Content-Type" : "multipart/form-data",
        "accept" : "*/*",
      };

      var body = {
        "heightInCm": selectHeight,
        "weightInKg": selectWeight,
        "yearOfBirth": selectYearOfBirth,
        "gender": selectGender.toLowerCase(),
      };

      request.headers.addAll(headers);
      request.fields.addAll(body);


      HttpClient httpClient = HttpClient()
        ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
      IOClient ioClient = IOClient(httpClient);


      http.StreamedResponse response = await ioClient.send(request);
      RemoveAppLoader();
      if (response.statusCode == 200) {
        return LoginModel.fromJson(jsonDecode(await response.stream.bytesToString()));
      }else{
        final Map<String, dynamic> data = jsonDecode(await response.stream.bytesToString());
        if (data.containsKey('message')) {
          AppToast.toastMessage("${data['message']}");
        } else {
          AppToast.toastMessage("${data['error']}");
        }
        return null;
      }
    } on Exception catch (e,st) {
      RemoveAppLoader();
      return null;
    }
  }

  Future<WeightRecordModel> getWeightRecordApiCall() async {
    try {
      WeightRecordModel model = await WeightRecordService.weightRecordData();

      if (model.statusCode == Constants.successCode200) {
        bodyInfoDataList.value = model.data?.weightRecordArray ?? [];
        if (bodyInfoDataList.length > 0) {
          createdDate = dateTime.format(
            DateTime.parse(
              bodyInfoDataList.last.createdAt ?? DateTime.now().toString(),
            ),
          );
          todayDate = dateTime.format(
            DateTime.parse(
              DateTime.now().toUtc().toString(),
            ),
          );
          DateTime start = new DateFormat("dd/MM/yyyy").parse(createdDate);
          DateTime end = new DateFormat("dd/MM/yyyy").parse(todayDate);
          differenceInDays = end.difference(start).inDays;
        }

        String dayTitle = 'WEIGHT_CHANGE_RECOMMENDATION'.tr;
        daysTitle.value =
            dayTitle.replaceAll('%d', differenceInDays.toString());

        /*int previousWeight=0;
        bool isWeightLoss=false;
        for(int a=bodyInfoDataTempList.length-1; a>=0; a--){
          String id=bodyInfoDataTempList[a].id ?? '';
          String userId=bodyInfoDataTempList[a].userId ?? '';
          String date=bodyInfoDataTempList[a].createdAt ?? '2022-09-26T10:10:04.000Z';
          int weight=bodyInfoDataTempList[a].weightInKg ?? 0;

          if(previousWeight<weight){
            previousWeight=weight-previousWeight;
            isWeightLoss=false;
            bodyInfoDataList.value.add(WeightRecord(id, userId, weight, previousWeight, date,isWeightLoss));
          }else{
            previousWeight=previousWeight-weight;
            isWeightLoss=true;
            bodyInfoDataList.value.add(WeightRecord(id, userId, weight, previousWeight, date,isWeightLoss));
          }
          previousWeight=weight;
        }*/
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
    return WeightRecordModel();
  }

  Future<WeightRecordModel> DeleteWeightRecord(
      {required int index, required String id}) async {
    try {
      AppLoader(Get.context!);
      WeightRecordModel model =
          await WeightRecordService.deleteWeightRecordData(id);
      RemoveAppLoader();
      if (model.statusCode == Constants.successCode200) {
        //ignore: invalid_use_of_protected_member
        bodyInfoDataList.value.removeAt(index);
        bodyInfoDataList.refresh();
        Navigation.pop();
      }
      return model;
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {}
    return WeightRecordModel();
  }

  Future getUserInfo() async {
    try {
      userModel.value = await UserService.getUserInfo();
      if (userModel.value.statusCode == Constants.successCode200) {
        if (userModel.value.data?.bmi != null) {
          Constants.isBodyInfoSelected.value = true;
        }
        setBodyData();
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  void setBodyData() {
    selectWeight = userModel.value.data?.weightInKg?.toString() ?? selectWeight;
    selectHeight = userModel.value.data?.heightInCm?.toString() ?? selectHeight;
    selectGender = userModel.value.data?.gender?.toString() ??
        Constants.MALE.toLowerCase();
    selectYearOfBirth =
        userModel.value.data?.yearOfBirth?.toString() ?? selectYearOfBirth;

    selectIndexWeight.value = weightList.indexWhere((note) {
      return note.toString() == selectWeight;
    });

    selectIndexHeight.value = heightList.indexWhere((note) {
      return note.toString() == selectHeight;
    });

    selectIndexYear.value = yearList.indexWhere((note) {
      return note.toString() == selectYearOfBirth;
    });

    if (selectGender.toLowerCase() == Constants.MALE.toLowerCase()) {
      Constants.isSelectMaleFemale.value = true;
    } else {
      Constants.isSelectMaleFemale.value = false;
    }
  }
}
