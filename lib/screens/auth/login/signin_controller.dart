import 'package:api_withgetx/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  Authservices authservices = Authservices();

  RxBool isLoading = false.obs;

  String get email => authservices.getEmail;
  set setEmail(String value) => authservices.setEmail = value;

  String get password => authservices.password;
  set setPassword(String value) => authservices.setPassword = value;
  Future<bool> signIn(BuildContext context) async {
    isLoading.value = true;
    bool result = await authservices.signIn(email, password);
    isLoading.value = false;
    return result;
  }
}
