import 'package:api_withgetx/controller/home_cotroller.dart';
import 'package:api_withgetx/controller/login_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => LoginController());
  }
}
