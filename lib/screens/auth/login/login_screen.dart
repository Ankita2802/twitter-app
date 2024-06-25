import 'dart:developer';
import 'package:api_withgetx/screens/auth/login/signin_controller.dart';
import 'package:api_withgetx/screens/home/home_screen.dart';
import 'package:api_withgetx/theme/app_color.dart';
import 'package:api_withgetx/theme/app_theme.dart';
import 'package:api_withgetx/utills/app_image.dart';
import 'package:api_withgetx/utills/utills.dart';
import 'package:api_withgetx/widget/app_button.dart';
import 'package:api_withgetx/widget/app_textformfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? emailError;
  bool hide = true;
  bool agreed = false;
  String? passwordError;

  SignInController signInController = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.100),
                Image.asset(
                  AppLogos.twitterLogo,
                  cacheHeight: 40,
                  cacheWidth: 40,
                ),
                const SizedBox(height: 20),
                Text(
                  'Log in to Twitter',
                  style: normalBlack.copyWith(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 50),
                AppTextFormField(
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  controller: emailController,
                  hintText: "email",
                  errorText: '*Please enter email ',
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChange: (value) {
                    signInController.setEmail = value;
                    if (emailError != null) {
                      setState(() {
                        emailError = null;
                        log(emailError.toString(), name: "email error");
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  error: passwordError,
                  controller: passwordController,
                  hintText: "password",
                  errorText: '*Please enter password ',
                  textInputType: TextInputType.text,
                  obscureText: hide,
                  textInputAction: TextInputAction.done,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: hide
                        ? const Icon(
                            Icons.visibility,
                            color: AppColors.appBlue,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: AppColors.appBlue,
                          ),
                    onPressed: () {
                      setState(() {
                        hide = !hide;
                      });
                    },
                  ),
                  onChange: (value) {
                    signInController.setPassword = value;
                    if (passwordError != null) {
                      setState(() {
                        passwordError = null;
                      });
                    }
                  },
                ),
                SizedBox(height: height * 0.100),
                Obx(() {
                  if (signInController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return AppButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await signInController.signIn(context);
                          if (success) {
                            Utils.toastMessage("Login Sucessfully");
                            Get.offAll(() => const HomeScreen());
                          } else {
                            Utils.toastMessage("Login Failed");
                          }
                        }
                      },
                      text: "Login",
                    );
                  }
                }),
                // Obx(() {
                //   if (signInController.token.isNotEmpty) {
                //     return Text('Token: ${loginController.token}');
                //   } else {
                //     return Container();
                //   }
                // }),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Not a Member?', style: normalBlack),
                      TextSpan(
                        text: ' Register',
                        style: boldBlue.copyWith(fontSize: 15),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed('/register');
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
