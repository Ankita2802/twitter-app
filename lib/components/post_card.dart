import 'dart:developer';
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
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        widget.userName,
                        style: boldBlack,
                      ),
                    ),
                  ),
            title: Text(
              widget.name,
              style: boldBlack,
            ),
            subtitle: Text('jan 21,2024',
                style: boldBlack.copyWith(
                    fontWeight: FontWeight.w400, fontSize: 18)),
            trailing: PopupMenuButton(
              itemBuilder: (ctx) => [
                buildPopupMenuItem(
                  'view Profile',
                  Icons.person,
                  context,
                  widget.userId,
                  widget.name,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              textAlign: TextAlign.start,
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
              horizontal: 10,
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

PopupMenuItem buildPopupMenuItem(String title, IconData iconData,
    BuildContext context, int id, String name) {
  return PopupMenuItem(
    child: GestureDetector(
      onTap: () {
        Get.back();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserScreen(
              id: id,
            ),
          ),
        );
      },
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          const SizedBox(width: 5),
          Text('View $name'),
        ],
      ),
    ),
  );
}
