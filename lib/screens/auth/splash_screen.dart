import 'dart:async';
import 'dart:developer';
import 'package:api_withgetx/auth_service/auth_service.dart';
import 'package:api_withgetx/screens/auth/login/login_screen.dart';
import 'package:api_withgetx/screens/home/home_screen.dart';
import 'package:api_withgetx/utills/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authServices = Authservices();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) => redirect());
  }

  // Future<void> redirect() async {
  //   await MySharedPreferences.instance.getStringValue("token").then(
  //     (value) {
  //       log(value.toString(), name: "login token value");
  //       if (value == null) {
  //         Get.offAll(() => const LoginScreen());
  //       } else {
  //         Get.offAll(() => const HomeScreen());
  //       }
  //     },
  //   );
  // }
  redirect() async {
    await authServices.getCurrentUser().then((value) {
      log(value.toString(), name: "user value");
      if (value == null) {
        Get.offAll(() => const LoginScreen());
      } else {
        Get.offAll(() => const HomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(AppLogos.twitterLogo),
    );
  }
}
