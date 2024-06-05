import 'dart:convert';
import 'dart:developer';
import 'package:api_withgetx/networking/networking.dart';
import 'package:api_withgetx/utills/api_urls.dart';
import 'package:api_withgetx/utills/my_sharepref.dart';
import 'package:get/get.dart';

class AuthRepositry extends ApiService {
  // regiser Api
  Future register(Map<String, dynamic> body) async {
    final response = await postHttp(data: body, api: ApiUrls.register);
    log(response.body, name: 'response signUp');
    log(response.statusCode.toString(), name: 'statusCode');
    var data = jsonDecode(response.body);
    var error = data['error'].toString();
    var token = data['token'].toString();
    log(error.toString(), name: 'error for signup');
    log(token.toString(), name: 'token for signup');
    if (response.statusCode == 200) {
      MySharedPreferences.instance.setStringValue("token", token);
      Get.snackbar("RegisterSuccesfully", token);
    } else {
      Get.snackbar("Failed", error);
    }
    return jsonDecode(response.body);
  }

  //login api
  Future login(Map<String, dynamic> body) async {
    final response = await postHttp(data: body, api: ApiUrls.login);
    log(response.body, name: 'response login');
    log(response.statusCode.toString(), name: 'statusCode');
    var data = jsonDecode(response.body);
    var error = data['error'].toString();
    var token = data['token'].toString();
    log(error.toString(), name: 'error for login');
    log(token.toString(), name: 'token for login');
    if (response.statusCode == 200) {
      MySharedPreferences.instance.setStringValue("token", token);
      Get.snackbar("LoginSucessfully", token);
    } else {
      Get.snackbar("Login Failed", error);
    }
    return jsonDecode(response.body);
  }
}
