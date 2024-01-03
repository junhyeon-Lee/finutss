import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:finutss/helper/exception_helper.dart';
import 'package:finutss/helper/toast_helper.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/token_error_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http_interceptor/http_interceptor.dart';

class NetworkAPICall {
  static final NetworkAPICall _networkAPICall = NetworkAPICall._internal();

  factory NetworkAPICall() {
    return _networkAPICall;
  }

/*  static Client get httpClient {
    return InterceptedClient.build(
      interceptors: [
        LoggerInterceptor(),
      ],
      retryPolicy: ExpiredTokenRetryPolicy(),
    );
  }*/

  static IOClient get httpClient {
    HttpClient httpClient = HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(httpClient);
    return ioClient;
  }

  NetworkAPICall._internal();

  String fullURL = '';

  static String BASE_URL = ApiConstants.baseUrl;

  Future<dynamic> post(String url, dynamic body, {Map<String, String>? header}) async {
    try {
      fullURL = BASE_URL + url;
      print('SignInService  logIn-------->fullURL::$fullURL,');
      final response = await httpClient.post(Uri.parse(fullURL), body: body, headers: header).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );

      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> put(String url, dynamic body, {Map<String, String>? header, bool isFromData = false, bool? isDecode}) async {
    try {
      fullURL = BASE_URL + url;

      if (isDecode ?? false) {
        body = json.encode(body);
      }
      final response = await httpClient.put(Uri.parse(fullURL), body: body, headers: header).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );

      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> get(String url, {Map<String, String>? header, bool isToken = true}) async {
    try {
      fullURL = BASE_URL + url;

      log('API header: $header');
      final response = await httpClient
          .get(
        Uri.parse(fullURL),
        headers: header,
      )
          .timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      if (response.statusCode == 401) {
        // tokenErrorDialog(Get.context!);
      }
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> getWithOutBaseURl(String url, {Map<String, String>? header, bool isToken = true}) async {
    try {
      fullURL = url;

      log('API header: $header');
      final response = await httpClient
          .get(
        Uri.parse(fullURL),
        headers: header,
      )
          .timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 401) {
        // tokenErrorDialog(Get.context!);
      }else if (data['status'] == "success") {
        return jsonDecode(response.body);
      }
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> patch(String url, {Map<String, String>? header, dynamic body, bool isToken = true}) async {
    try {
      fullURL = BASE_URL + url;
      log('API Url: $fullURL');
      log('API header: $header');
      final response = await httpClient
          .patch(
        Uri.parse(fullURL),
        body: body,
        headers: header,
      )
          .timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> delete(String url, {Map<String, String>? header, dynamic body}) async {
    try {
      final String fullURL = BASE_URL + url;
      final response = await httpClient.delete(Uri.parse(fullURL), headers: header, body: body).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  dynamic checkResponse(http.Response response) {
    try {
      switch (response.statusCode) {
        case Constants.successCode200:
          try {
            final Map<String, dynamic> data = jsonDecode(response.body);
            if (data['statusCode'] != Constants.successCode200) {
              if (data.containsKey('message')) {
                return AppToast.toastMessage("${data['message']}");
              } else {
                return AppToast.toastMessage("${data['error']}");
              }
            }  else {
              return jsonDecode(response.body);
            }
          } catch (e) {
            print("Exception ------> $e");
            rethrow;
          }

        case Constants.successCode201:
          try {
            final Map<String, dynamic> data = jsonDecode(response.body);

            if (data['statusCode'] != Constants.successCode200) {
              if (fullURL.contains('user/signup') ||
                  fullURL.contains('follow') ||
                  fullURL.contains('/blacklist') ||
                  fullURL.contains('report') ||
                  fullURL.contains('/verify/email')) {
                if (data['statusCode'] == Constants.successCode201) {
                  return jsonDecode(response.body);
                } else {
                  if (data.containsKey('message')) {
                    return AppToast.toastMessage("${data['message']}");
                  } else {
                    return AppToast.toastMessage("${data['error']}");
                  }
                }
              } else {
                if (data.containsKey('message')) {
                  return AppToast.toastMessage("${data['message']}");
                } else {
                  return AppToast.toastMessage("${data['error']}");
                }
              }
            } else if (data['statusCode'] == Constants.successCode200) {
              if (fullURL.contains('user/withdraw') || fullURL.contains('record') || fullURL.contains(ApiConstants.resendOtp)) {
                if (data['statusCode'] == Constants.successCode200) {
                  return jsonDecode(response.body);
                } else {
                  if (data.containsKey('message')) {
                    return AppToast.toastMessage("${data['message']}");
                  } else {
                    return AppToast.toastMessage("${data['error']}");
                  }
                }
              } else {
                return jsonDecode(response.body);
              }
            } else {
              return jsonDecode(response.body);
            }
          } catch (e) {
            rethrow;
          }

        case Constants.successCode403:
          try {
            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }

        case Constants.successCode404:
          try {
            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }

        case Constants.successCode406:
          try {
            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }

        case Constants.successCode400:
          try {
            final Map<String, dynamic> data = jsonDecode(response.body);
            return AppToast.toastMessage("${data['error']}");
          } catch (e) {
            rethrow;
          }

        case Constants.expireCode:
          try {
            final Map<String, dynamic> data = jsonDecode(response.body);
            if (data['statusCode'] == Constants.expireCode) {
              //sessionExpiredDialog(Get.context!);
              if (Constants.isGuest == false && Constants.isLogin) {
                log(data['statusCode'].toString());
                tokenErrorDialog(Get.context!);
              }
            }
          } catch (e) {
            rethrow;
          }
          break;

        default:
          try {
            if (!response.body.isEmpty) {
              print("data ========== ${jsonDecode(response.body)}");
              final Map<String, dynamic> data = jsonDecode(response.body);
              return AppToast.toastMessage("${data['error']}");

              // throw AppException(message: 'Response body is empty', errorCode: response.statusCode);
            } else {
              final Map<String, dynamic> data = jsonDecode(response.body);
              throw AppException(message: "error : ${data['error']}", errorCode: response.statusCode);
            }
          } catch (e) {
            rethrow;
          }
      }
    } catch (e) {
      rethrow;
    }
  }
}

class LoggerInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401) {}
    return data;
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 2;

  @override
  bool shouldAttemptRetryOnException(Exception reason) {
    return false;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      ///token expire to call
      return true;
    }
    return false;
  }
}
