import 'package:http/http.dart' as http;

class LogUtils{
  static Future logMSG(dynamic error, StackTrace stackTrace) async {
    var body = {
      "entry.698904961": '${error}',
      "entry.1915020275": '${stackTrace}',
    };

    var client = http.Client();

    var _url = 'https://docs.google.com/forms/u/0/d/e/1FAIpQLSe2RN60q97gk4Ymb7VVyO_DPgPB4qw8CAXLCRzqhoN4dFVmkA/formResponse';
    try {
      var resutl = await client.post(Uri.parse(_url), body: body);

      // print("LogUtils Api Restul : ${Uri.parse(_url)}");
      // print("LogUtils Api Restul : ${resutl.statusCode}");
      // print("LogUtils Api Restul : ${resutl.body}");
    } catch (e) {
      // print("LogUtils APi Error======== : $e");
    }
  }
}