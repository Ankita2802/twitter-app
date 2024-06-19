import 'dart:developer';
import 'package:api_withgetx/screens/auth/register/register_controller.dart';
import 'package:api_withgetx/theme/app_color.dart';
import 'package:api_withgetx/theme/app_theme.dart';
import 'package:api_withgetx/utills/app_image.dart';
import 'package:api_withgetx/utills/utills.dart';
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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? emailError;
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool showSpinner = false;
  String? passwordError;
  String? confirmPasswordError;
  String? phonedError;
  String? firstNameError;
  String? lastNameError;

  final _formKey = GlobalKey<FormState>();

  RegisterController registerController = Get.put(RegisterController());

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
                  error: firstNameError,
                  controller: firstNameController,
                  hintText: "first name",
                  errorText: '*Please enter firstName ',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onChange: (value) {
                    registerController.setFirstName = value;
                    if (firstNameError != null) {
                      setState(() {
                        firstNameError = null;
                        log(
                          firstNameError.toString(),
                          name: "firstName error",
                        );
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  error: lastNameError,
                  controller: lastNameController,
                  hintText: "last name",
                  errorText: '*Please enter lastName ',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onChange: (value) {
                    registerController.setLastName = value;
                    if (lastNameError != null) {
                      setState(() {
                        lastNameError = null;
                        log(lastNameError.toString(), name: "lastName error");
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  error: phonedError,
                  controller: phoneController,
                  hintText: "phone",
                  errorText: '*Please enter phone ',
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone';
                    } else if (value.length != 10) {
                      return 'Phone number should contain exactly 10 digits';
                    } else if (!Utils.isPhone(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  onChange: (value) {
                    registerController.setPhone = value;
                    if (phonedError != null) {
                      setState(() {
                        phonedError = null;
                        log(phonedError.toString(), name: "phone error");
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  error: emailError,
                  controller: emailController,
                  hintText: "email",
                  errorText: '*Please enter email ',
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!Utils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChange: (value) {
                    registerController.setEmail = value;
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
                  obscureText: hidePassword,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (!Utils.isPasswordValid(value)) {
                      return 'Password should contain at least one uppercase letter';
                    } else if (value.length < 8) {
                      return 'Password should contain at least 8 characters';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  suffixIcon: IconButton(
                    icon: hidePassword
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
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                  onChange: (value) {
                    registerController.setPassword = value;
                    if (passwordError != null) {
                      setState(() {
                        passwordError = null;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  error: confirmPasswordError,
                  controller: confirmpasswordController,
                  hintText: "confirm password",
                  errorText: '*Please enter confirm password ',
                  textInputType: TextInputType.text,
                  obscureText: hideConfirmPassword,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your confirm password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    icon: hideConfirmPassword
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
                        hideConfirmPassword = !hideConfirmPassword;
                      });
                    },
                  ),
                  onChange: (value) {
                    registerController.setConfirmPassword = value;
                    if (confirmPasswordError != null) {
                      setState(() {
                        confirmPasswordError = null;
                      });
                    }
                  },
                ),
                const SizedBox(height: 30),
                Obx(() {
                  if (registerController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return AppButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success =
                              await registerController.signUP(context);
                          if (success) {
                            Get.toNamed('/home');
                            Utils.toastMessage("SignUp Sucessfully");
                          } else {
                            Utils.toastMessage("Signup Failed");
                          }
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
                      '/login',
                    ); // This will navigate to LoginScreen and remove all previous routes
                  },
                  child: Center(
                    child: Text(
                      "Already have an account? Log In Here!",
                      style: normalBlack.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
