import 'package:api_withgetx/components/post_card.dart';
import 'package:api_withgetx/theme/app_color.dart';
import 'package:api_withgetx/utills/app_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          leading: Icon(
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider(
                height: 1,
                thickness: 0,
                color: Colors.grey,
              );
            },
            itemCount: 10,
            itemBuilder: (context, index) {
              // var postItem = post[index];
              // var userId = postItem.userId;
              // var userName = userNames[userId] ?? 'No name';
              // var postname = profileUserName[userId] ?? 'No name';
              return const PostCard(
                name: 'ankkta',
                postbody: 'cmnbvcx vhjbcvczc shjvbhvjc',
                userId: 0,
                userName: 'ankita vaghela',
                id: 1,
                postId: 2,
              );
            },
          ),
        ));
  }
}
