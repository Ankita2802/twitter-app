import 'dart:developer';
import 'package:api_withgetx/repositry/auth_repo.dart';
import 'package:api_withgetx/utills/my_sharepref.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  AuthRepositry repo = AuthRepositry();

  String _email = '';
  String get getEmail => _email;
  set setEmail(value) => _email = value;

  String _password = '';
  String get password => _password;
  set setPassword(String val) => _password = val;
  var token = ''.obs;

  var isLoading = false.obs;
  Future<bool> login() async {
    isLoading(true);
    try {
      Map<String, dynamic> data = {"email": _email, "password": _password};
      final response = await repo.login(data);
      log(response.toString(), name: 'response login');

      if (response['error'] != null  ) {
        Get.snackbar('Login Failed', response['error']);
        return false;
      } else if (response['token'] != null) {
        token.value = response['token'];
        MySharedPreferences.instance.setStringValue("token", token.value);
        Get.snackbar("Login Successfully", response['token']);
        return true;
      } else {
        Get.snackbar('Error', 'Unexpected error occurred');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    } finally {
      isLoading(false);
    }
  }
}
