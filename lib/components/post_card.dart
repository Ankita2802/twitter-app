import 'dart:developer';
import 'package:api_withgetx/auth_service/auth_service.dart';
import 'package:api_withgetx/controller/comment_controller.dart';
import 'package:api_withgetx/controller/home_cotroller.dart';
import 'package:api_withgetx/screens/auth/user/user_screen.dart';
import 'package:api_withgetx/theme/app_color.dart';
import 'package:api_withgetx/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCard extends StatefulWidget {
  final String name;
  final String postbody;
  final int userId;
  final String userName;
  final int commentsId;

  const PostCard({
    super.key,
    required this.name,
    required this.postbody,
    required this.userId,
    required this.userName,
    required this.commentsId,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    log(widget.userId.toString(), name: 'user Id');
    super.initState();
  }

  bool isLiked = false;
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: widget.userName.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.appBlue.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        widget.userName,
                        style: boldBlack.copyWith(fontSize: 10),
                      ),
                    ),
                  ),
            title: Text(
              widget.name,
              style: boldBlack,
            ),
            subtitle: Text(
              '29/01/2024',
              style: boldBlack.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: PopupMenuButton(
              itemBuilder: (ctx) => [
                buildPopupMenuItem(
                    'Profile', Icons.person, context, widget.userId),
                buildPopupMenuItem(
                    'Logout', Icons.exit_to_app, context, widget.userId),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.postbody,
              style: boldBlack.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.black,
                  ),
                  onPressed: toggleLike,
                  iconSize: 20.0,
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    showBottomSheetComment(context, widget.commentsId);
                  },
                  child: const Icon(Icons.comment),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    await Get.find<HomeController>()
                        .removePost(widget.commentsId.toString())
                        .then((value) {
                      Get.find<HomeController>().post.removeWhere(
                            (post) => post.id == widget.commentsId,
                          );
                    });
                  },
                  child: const Icon(
                    Icons.delete,
                    size: 20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

void showBottomSheetComment(BuildContext context, int commentsId) {
  final CommentsController commentsController = Get.find();
  commentsController.getCommets(commentsId);

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const BeveledRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        height: Get.height * 0.60,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Obx(() {
          if (commentsController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Comments',
                  textAlign: TextAlign.center,
                  style: boldBlack.copyWith(fontSize: 25),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    itemCount: commentsController.comments.length,
                    itemBuilder: (context, index) {
                      final comment = commentsController.comments[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(2, 5),
                                blurStyle: BlurStyle.normal,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.appBlue.withOpacity(0.2),
                                  width: 2,
                                ),
                              ),
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                ),
                              ),
                            ),
                            title: Text(
                              comment.name ?? 'No name',
                              style: boldBlue.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            subtitle: Text(
                              comment.body ?? 'No comment',
                              style: normalBlack.copyWith(
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }),
      );
    },
  );
}

PopupMenuItem buildPopupMenuItem(
    String title, IconData iconData, BuildContext context, int id) {
  return PopupMenuItem(
    child: GestureDetector(
      onTap: () {
        Get.back();
        if (title == "Profile") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserScreen(
                id: id,
              ),
            ),
          );
        } else if (title == "Logout") {
          showLogoutDialog();
        }
      },
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          const SizedBox(width: 5),
          Text(title),
        ],
      ),
    ),
  );
}

final authServices = Authservices();

void showLogoutDialog() {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: Get.height * 0.250,
        width: Get.width * 0.250,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Confirm Logout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Are you sure you want to log out?'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    authServices.signOut();
                    Get.back();
                    Get.offAllNamed('/login'); // Navigate to the login screen
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
