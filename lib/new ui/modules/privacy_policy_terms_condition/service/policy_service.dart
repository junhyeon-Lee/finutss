import 'dart:convert';
import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/new%20ui/modules/privacy_policy_terms_condition/model/privacy_policy_model.dart';
import 'package:http/http.dart' as http;

class PolicyService{
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<PrivacyPolicyModel> getPolicy(String url) async {
    try {

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (response != null) {
          return PrivacyPolicyModel.fromJson(json.decode(response.body));
        }
      } else {
        throw "Unable to retrieve posts.";
      }
     

    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return PrivacyPolicyModel();
  }

}