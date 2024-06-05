import 'dart:async';

import 'package:api_withgetx/utills/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.toNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(AppLogos.twitterLogo),
    );
  }
}
