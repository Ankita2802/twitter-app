import 'dart:developer';
import 'package:api_withgetx/models/post_model.dart';
import 'package:api_withgetx/models/user_model.dart';
import 'package:api_withgetx/repositry/post_repo.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  PostRepositry repo = PostRepositry();
  Rx<UserModel> users = UserModel().obs;
  RxList<UserModel> user = <UserModel>[].obs;
  RxList<UserModel> userDetail = <UserModel>[].obs;
  RxList<PostsModel> post = <PostsModel>[].obs;
  RxInt id = 0.obs;

  /// get All user
  Future<void> getUsers() async {
    try {
      final response = await repo.getUsers();
      log(response.toString(), name: 'getUsers');
      response.forEach((element) {
        user.add(UserModel.fromJson(element));
      });

      log(user.toString(), name: 'users');
    } catch (e, s) {
      log(e.toString(), name: 'error getPosts', stackTrace: s);
    }
  }

  //get particular user
  Future<void> getParticulatUsers(String id) async {
    try {
      final response = await repo.getParicularUsers(id);
      log(response.toString(), name: 'getUsersParticlarid');
      response.forEach((element) {
        userDetail.add(UserModel.fromJson(element));
      });
    } catch (e, s) {
      log(e.toString(), name: 'error getUsersparticular', stackTrace: s);
    }
  }
}
