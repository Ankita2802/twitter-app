import 'package:api_withgetx/routes/app_pages.dart';
import 'package:api_withgetx/screens/auth/splash_screen.dart';
import 'package:api_withgetx/widget/controller_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Api_withGetx',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
      initialBinding: ControllerBinding(),
      home: const SplashScreen(),
    );
  }
}
