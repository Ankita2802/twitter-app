import 'dart:developer';
import 'package:api_withgetx/repositry/auth_repo.dart';
import 'package:api_withgetx/utills/utills.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  AuthRepositry repo = AuthRepositry();

  String _email = '';
  String get getEmail => _email;
  set setEmail(value) => _email = value;

  String _password = '';
  String get password => _password;
  set setPassword(String val) => _password = val;
  var token = ''.obs;

  var isLoading = false.obs;
  Future<bool> signUP() async {
    isLoading(true);
    try {
      Map<String, dynamic> data = {"email": _email, "password": _password};
      final response = await repo.register(data);
      log(response.toString(), name: 'response Register');
      if (response == null) {
        Utils.toastMessage(response['error'].toString());
      }
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
    return false;
  }
}
