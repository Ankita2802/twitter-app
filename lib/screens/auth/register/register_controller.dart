import 'package:api_withgetx/auth_service/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  Authservices authservices = Authservices();

  RxBool isLoading = false.obs;

  String get email => authservices.getEmail;
  set setEmail(String value) => authservices.setEmail = value;

  String get password => authservices.password;
  set setPassword(String value) => authservices.setPassword = value;

  String get confirmPassword => authservices.confirmPassword;
  set setConfirmPassword(String value) => authservices.setConfirmPassword = value;

  String get phone => authservices.phone;
  set setPhone(String value) => authservices.setPhone = value;

  String get firstName => authservices.firstName;
  set setFirstName(String value) => authservices.setFirstName = value;

  String get lastName => authservices.lastName;
  set setLastName(String value) => authservices.setLastName = value;

  Future<bool> signUP(BuildContext context) async {
    isLoading.value = true;
    bool result = await authservices.signUp(email, phone, password, context);
    isLoading.value = false;
    return result;
  }
}
