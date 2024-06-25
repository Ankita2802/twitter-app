import 'dart:developer';

import 'package:api_withgetx/controller/user_controller.dart';
import 'package:api_withgetx/models/user_model.dart';
import 'package:api_withgetx/theme/app_color.dart';
import 'package:api_withgetx/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UserScreen extends StatefulWidget {
  final int id;

  const UserScreen({
    super.key,
    required this.id,
  });

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserController userController = Get.put(UserController());
  Map<int, String> userNames = {};
  String fullName = '';
  @override
  void initState() {
    userController.getParticulatUsers(widget.id.toString()).then((value) {
      for (var user in Get.find<UserController>().user) {
        if (user.id != null && user.name != null) {
          final name = user.name.toString();

          List<String> words = name.split(' ');

          if (words.length >= 2) {
            String firstNameInitial = words[0][0];
            String lastNameInitial = words[1][0];
            fullName = firstNameInitial + lastNameInitial;

            log(fullName, name: 'initial string');
          }
          userNames[user.id!] = fullName;
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return userController.userDetail.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: userController.userDetail.length,
                  itemBuilder: (context, index) {
                    var user = userController.userDetail[index];

                    var userId = user.id;
                    var userName = userNames[userId];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: Get.height * 0.4,
                              width: double.infinity,
                              color: AppColors.appBlue,
                            ),
                            Positioned(
                              top: Get.height * 0.400 / 6,
                              left: 20,
                              right: 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: Get.height * 0.34,
                              child: Container(
                                height: Get.height * 0.130,
                                width: Get.width * 0.200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.indigo,
                                    width: 3,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    userName ?? 'As',
                                    style: boldBlack,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        _buildHeader(user),
                        SizedBox(height: Get.height * 0.010),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            bottom: 20,
                          ),
                          child: Text(
                            "About",
                            style: boldBlack.copyWith(fontSize: 24),
                          ),
                        ),
                        _buildContactInfo(user),
                        const SizedBox(height: 16.0),
                        _buildAddress(user),
                        const SizedBox(height: 16.0),
                        _buildCompanyInfo(user),
                      ],
                    );
                  });
        },
      ),
    );
  }
}

Widget _buildHeader(UserModel? user) {
  return Padding(
    padding: const EdgeInsets.only(top: 50),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            user?.name ?? 'no name',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            '@${user?.username ?? 'no usernae'}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}

Widget _buildContactInfo(UserModel? user) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Info',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Icon(Icons.email, color: Colors.blue),
            const SizedBox(width: 8.0),
            Text(user?.email ?? 'no email'),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.blue),
            const SizedBox(width: 8.0),
            Text(user?.phone ?? 'no phone'),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Icon(Icons.web, color: Colors.blue),
            const SizedBox(width: 8.0),
            Text(user?.website ?? ' no website'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAddress(UserModel? user) {
  final address = user?.address;
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Address',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Text('${address?.street}, ${address?.suite}'),
        Text('${address?.city}, ${address?.zipcode}'),
      ],
    ),
  );
}

Widget _buildCompanyInfo(UserModel? user) {
  final company = user?.company;
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Company',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Text(company?.name ?? 'no name'),
        const SizedBox(height: 8.0),
        Text('Catch Phrase: ${company?.catchPhrase ?? ' no catch'}'),
        const SizedBox(height: 8.0),
        Text('BS: ${company?.bs ?? 'no bs'}'),
      ],
    ),
  );
}
