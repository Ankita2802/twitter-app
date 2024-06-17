import 'dart:developer';
import 'package:api_withgetx/models/comments_model.dart';
import 'package:api_withgetx/repositry/post_repo.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  PostRepositry repo = PostRepositry();
  var comments = <CommentsModel>[].obs;
  var isLoading = false.obs;

  /// get All Comments
  Future<void> getCommets(int postId) async {
    try {
      isLoading(true);
      final response = await repo.comments(postId);
      log(response.toString(), name: 'getComments');
      comments.clear();
      response.forEach((element) {
        comments.add(CommentsModel.fromJson(element));
      });
    } catch (e, s) {
      log(e.toString(), name: 'error getComments', stackTrace: s);
    } finally {
      isLoading(false);
    }
  }
}
