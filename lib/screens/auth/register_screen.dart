import 'dart:developer';
import 'package:api_withgetx/controller/signup_controller.dart';
import 'package:api_withgetx/theme/app_color.dart';
import 'package:api_withgetx/theme/app_theme.dart';
import 'package:api_withgetx/utills/app_image.dart';
import 'package:api_withgetx/widget/app_button.dart';
import 'package:api_withgetx/widget/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailError;
  bool hide = false;
  String? passwordError;
  SignupController signupController = Get.put(SignupController());
  final _formKey = GlobalKey<FormState>();
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
                Text(
                  'Join Twitter Today',
                  style: normalBlack.copyWith(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  AppLogos.twitterLogo,
                  cacheHeight: 40,
                  cacheWidth: 40,
                ),
                const SizedBox(height: 50),
                AppTextFormField(
                    error: emailError,
                    controller: emailController,
                    hintText: "email",
                    errorText: '*Please enter email ',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChange: (value) {
                      signupController.setEmail = value;
                      if (emailError != null) {
                        setState(() {
                          emailError = null;
                          log(emailError.toString(), name: "email error");
                        });
                      }
                    }),
                const SizedBox(height: 20),
                AppTextFormField(
                  error: passwordError,
                  controller: passwordController,
                  hintText: "password",
                  errorText: '*Please enter password ',
                  textInputType: TextInputType.text,
                  obscureText: hide,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    icon: hide
                        ? const Icon(
                            Icons.visibility_off,
                            color: AppColors.appBlue,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: AppColors.appBlue,
                          ),
                    onPressed: () {
                      setState(() {
                        hide = !hide;
                      });
                    },
                  ),
                  onChange: (value) {
                    signupController.setPassword = value;
                    if (passwordError != null) {
                      setState(() {
                        passwordError = null;
                      });
                    }
                  },
                ),
                const SizedBox(height: 30),
                Obx(() {
                  if (signupController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return AppButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await signupController.signUP().then(
                            (value) {
                              Navigator.pop(context);
                              if (value) {
                                Get.toNamed('/home');
                              }
                            },
                          );
                        }
                      },
                      text: "SignUP",
                    );
                  }
                }),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(
                        '/login'); // This will navigate to LoginScreen and remove all previous routes
                  },
                  child: Center(
                    child: Text(
                      "Already have an account? Log In Here!",
                      style: normalBlack.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
