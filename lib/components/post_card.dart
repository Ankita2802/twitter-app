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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              // Navigate to UserScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserScreen(
                    id: widget.userId,
                  ),
                ),
              );
            },
            leading: Container(
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
              '29/01/2020',
              style: boldBlack.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w300,
              ),
            ),
            trailing: const Icon(
              Icons.more_vert,
              size: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Text(
              widget.postbody,
              style: boldBlack.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite_border),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showBottomSheetComment(context, widget.commentsId);
                      },
                      child: const Icon(Icons.comment),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.share)
                  ],
                ),
                Row(
                  children: [
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
                      child: const Icon(Icons.delete),
                    )
                  ],
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
        height: Get.height * 0.80,
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
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.name ?? 'No name',
                              style: boldBlue.copyWith(fontSize: 14),
                            ),
                            Text(
                              comment.email ?? 'No email',
                              style: boldBlack.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          comment.body ?? 'No comment',
                          style: normalBlack,
                        ),
                        trailing: const Icon(Icons.favorite_border),
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
