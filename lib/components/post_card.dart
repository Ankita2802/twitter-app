import 'dart:developer';
import 'package:api_withgetx/theme/app_color.dart';
import 'package:api_withgetx/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCard extends StatefulWidget {
  final String name;
  final String postbody;
  final int userId;
  final String userName;
  final int id;
  final int postId;
  const PostCard({
    super.key,
    required this.name,
    required this.postbody,
    required this.userId,
    required this.userName,
    required this.id,
    required this.postId,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  // late PostProvider provider;
  // @override
  // void initState() {
  //   provider = Provider.of<PostProvider>(context, listen: false);
  //   log(widget.id.toString(), name: 'post Id');
  //   log(widget.postId.toString(), name: 'comments Id');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              Get.toNamed('/user');
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => UserScreen(
              //       id: widget.userId,
              //       userName: widget.userName,
              //     ),
              //   ),
              // );
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
                  widget.name.isNotEmpty ? widget.name : 'N',
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
                      onTap: () async {},
                      child: const Icon(Icons.comment),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.share)
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.save_alt),
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
