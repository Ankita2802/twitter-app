import 'dart:developer';
import 'package:api_withgetx/models/post_model.dart';
import 'package:api_withgetx/repositry/post_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  PostRepositry repo = PostRepositry();
  RxList<PostsModel> post = <PostsModel>[].obs;

  /// get All post
  Future<void> getPost() async {
    try {
      final response = await repo.getAllposts();
      log(response.toString(), name: 'getposts');

      response.forEach((element) {
        post.add(PostsModel.fromJson(element));
      });
      log(post.toString(), name: 'matchPosts');
    } catch (e, s) {
      log(e.toString(), name: 'error getPosts', stackTrace: s);
    }
  }

}
