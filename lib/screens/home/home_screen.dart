import 'dart:developer';

import 'package:api_withgetx/components/post_card.dart';
import 'package:api_withgetx/controller/home_cotroller.dart';
import 'package:api_withgetx/controller/user_controller.dart';
import 'package:api_withgetx/utills/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  UserController userController = Get.put(UserController());
  Map<int, String> userNames = {};
  Map<int, String> profileUserName = {};
  String fullName = '';
  @override
  void initState() {
    homeController.getPost();
    fetchUser();
    super.initState();
  }

  Future fetchUser() async {
    await userController.getUsers().then((value) {
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
          profileUserName[user.id!] = name;
          log('User ID: ${user.id}, Name: ${user.name}', name: 'User Data');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Image.asset(
          AppLogos.twitterLogo,
          cacheHeight: 30,
          cacheWidth: 30,
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.person_outline,
          color: Colors.black,
          size: 30,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: Obx(() {
        return homeController.post.isNotEmpty
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                      thickness: 0,
                      color: Colors.grey,
                    );
                  },
                  itemCount: homeController.post.length,
                  itemBuilder: (context, index) {
                    var post = homeController.post[index];

                    var userId = post.userId;
                    log(userNames[userId].toString());
                    var userName = userNames[userId] ?? 'No name';
                    log(userName.toString(), name: 'user name');
                    var profileUsername = profileUserName[userId];
                    return PostCard(
                      name: profileUsername ?? 'no profile user name',
                      postbody: post.body ?? ' no body',
                      userId: 0,
                      userName: userName,
                      id: post.id ?? 0,
                      postId: 2,
                    );
                  },
                ),
              )
            : const Center(
                child: Text("No post avilable"),
              );
      }),
    );
  }
}
